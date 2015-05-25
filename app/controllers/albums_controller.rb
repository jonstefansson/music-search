class AlbumsController < ApplicationController
  def index
  end

  def search
    query = Jbuilder.encode do |json|
      json.aggregations do
        json.set! 'filtered-agg' do
          json.filter do
            json.query do
              json.set! 'query_string' do
                json.query "playlists:#{params[:playlist]} AND -album: Today's Top Tune"
              end
            end
          end
          json.aggregations do
            json.albums do
              json.terms do
                json.field "album.raw"
                json.size 0
              end
            end
          end
        end
      end
    end

    client = Elasticsearch::Client.new log: true
    response = client.search index: 'music', body: query, search_type: 'count'
    mash = Hashie::Mash.new response
    @results = mash.aggregations
    render partial: 'results'
  end
end
