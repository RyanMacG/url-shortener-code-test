class UrlShortenerController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    code = shortener.shorten(url: params[:url])
    response = { short_url: code, url: params[:url] }
    render json: response
  end

  def index
    render json: store
  end

  def code
    redirect_data = store.find { |u| u[:short_url] == params[:short_url] }

    if redirect_data
      redirect_to redirect_data[:url]
    else
      redirect_to action: 'index'
    end
  end

  private

  def store
    UrlShortenerService::URL_STORE
  end

  def shortener
    UrlShortenerService.new
  end
end
