class Playlist

  attr_reader :name, :playlist_id, :playlist_persistent_id, :playlist_items

  def initialize(params)
    params.each do |k,v|
      self.instance_variable_set("@#{k.gsub(/\s+/, '_').underscore}", v)
    end
    if @playlist_items.nil?
      @playlist_items = []
    else
      @playlist_items.collect! do |v|
        v['Track ID']
      end
    end
  end

  def index?
    ![
        'Library',
        'Music',
        'Movies',
        'TV Shows',
        'Podcasts',
        'iTunes U',
        'Tones',
        'Purchased',
        'Genius',
        'Music Videos',
        'Recently Added',
        'Recently Played',
        'Top 25 Most Played',
        'My Top Rated'
    ].member?(@name)
  end

end
