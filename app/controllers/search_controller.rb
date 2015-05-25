class SearchController < ApplicationController
  def index
  end

  def search
    query = Jbuilder.encode do |json|
      json.from params[:from]
      json.size params[:size]
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
    Rails.logger.ap response
    mash = Hashie::Mash.new response
    @results = mash.hits
    render partial: 'results'
  end
end
