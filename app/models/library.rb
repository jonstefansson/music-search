class Library

  attr_reader :tracks, :playlists

  INDEX_NAME = 'music'

  def initialize(path_to_xml)
    plist = Plist::parse_xml(path_to_xml)

    @tracks = plist['Tracks'].collect do |k,v|
      params = ActionController::Parameters.new(v).permit!
      Track.new(params)
    end

    @playlists = plist['Playlists'].collect do |x|
      params = ActionController::Parameters.new(x).permit!
      Playlist.new(params)
    end

    process_playlists

    plist = nil
  end

  def load_index
    @client = Elasticsearch::Client.new log: true
    delete_index
    create_index
    @tracks.each do |track|
      if track.index?
        @client.create index: INDEX_NAME,
                       type: 'track',
                       id: track.track_id.to_s,
                       body: {
                           artist:        track.artist,
                           album_artist:  track.album_artist,
                           album:         track.album,
                           name:          track.name,
                           genre:         track.genre,
                           year:          track.year ? track.year : 1970,
                           date_added:    track.date_added,
                           persistent_id: track.persistent_id,
                           disc_number:   track.disc_number,
                           disc_count:    track.disc_count,
                           track_number:  track.track_number,
                           track_count:   track.track_count,
                           playlists:     track.playlists
                       }
        ap "Added track #{track.track_id} to index"
      end
    end
    optimize_index
  end

  private

  def delete_index
    if @client.indices.exists index: INDEX_NAME
      @client.indices.delete index: INDEX_NAME
      ap "#{INDEX_NAME} deleted"
    end
  end

  def create_index
    mappings = JSON.load Rails.root.join('curl', 'mappings', 'music-mapping.json')
    @client.indices.create index: INDEX_NAME, body: mappings
    ap "#{INDEX_NAME} created"
  end

  def optimize_index
    @client.indices.optimize index: INDEX_NAME
    ap "#{INDEX_NAME} optimized"
  end

  def process_playlists
    index = index_playlist
    @tracks.each do |track|
      if track.index?
        track.playlists.concat(index[track.track_id])
      end
    end
  end

  def index_playlist
    @playlists.inject(Hash.new{ |hash, key| hash[key] = [] }) do |memo, playlist|
      if playlist.index?
        playlist.playlist_items.each do |track_id|
          memo[track_id] << playlist.name
        end
      end
      memo
    end
  end

end
