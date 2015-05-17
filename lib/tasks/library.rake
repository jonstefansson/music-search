namespace :library do

  desc 'Parse the iTunes music library plist and build index'
  task :index => :parse_library do
    @library.load_index
  end

  desc 'Dump a list of tracks'
  task :dump_library => :parse_library do
    @library = Library.new(File.expand_path('~/Documents/music/Library.xml'))
    ap @library.tracks
           .find_all(&:index?)
           .collect{|track| {track_id: track.track_id, artist: track.artist, album: track.album, name: track.name, playlists: track.playlists}}

  end

  desc 'Parse the library.xml file'
  task :parse_library => :environment do
    @library = Library.new(File.expand_path('~/Documents/music/Library.xml'))
  end

end
