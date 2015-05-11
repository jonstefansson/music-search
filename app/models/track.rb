class Track

  attr_reader :track_id, :name, :artist, :album_artist, :composer, :album,
              :genre, :kind, :size, :total_time, :disc_number, :disc_count,
              :track_number, :track_count, :year, :date_added, :bit_rate,
              :sample_rate, :comments, :persistent_id, :track_type, :location,
              :podcast, :playlists, :disabled

  def initialize(params)
    params.each do |k,v|
      self.instance_variable_set("@#{k.gsub(/\s+/, '_').underscore}", v)
    end
    @playlists = []
  end

  def index?
    !(@genre.eql?('Podcast') ||
      @kind.include?('video') ||
      @podcast ||
      @disabled
    )
  end

end
