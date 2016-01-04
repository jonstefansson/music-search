class SearchController < ApplicationController

  def index
    playlists
  end

  def search
    @page = Page.new(
        from: params[:from].to_i,
        size: params[:size].to_i
    )
    query = Jbuilder.encode do |json|
      json.from @page.from
      json.size @page.size
      json.query do
        json.match do
          json.set! params[:field] do
            json.query    params[:query]
            json.operator 'and'
          end
        end
      end
    end


    response = search_client.search index: 'music', body: query
    mash = Hashie::Mash.new response
    @page.calculate_next(mash.hits.total.to_i)
    @results = mash.hits
    render partial: 'results'
  end

  def search_client
    @search_client ||= begin
      Elasticsearch::Client.new log: true
    end
  end

  def playlists
    @playlists ||= begin
      query = Jbuilder.encode do |json|
        json.aggregations do
          json.playlists do
            json.terms do
              json.field 'playlists'
              json.size 0
            end
          end
        end
      end
      begin
        response = search_client.search index: 'music', body: query, search_type: 'count'
        mash = Hashie::Mash.new response
        mash.aggregations.playlists.buckets.collect{|item| item['key'] }
      rescue => e
        ap({source: 'playlists exception', exception: e})
        mash = []
      mash
      end
    end
  end

end
