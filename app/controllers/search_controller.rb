class SearchController < ApplicationController
  def index
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


    client = Elasticsearch::Client.new log: true
    response = client.search index: 'music', body: query
    mash = Hashie::Mash.new response
    @page.calculate_next(mash.hits.total.to_i)
    @results = mash.hits
    render partial: 'results'
  end
end
