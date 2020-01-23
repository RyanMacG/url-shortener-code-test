require 'rails_helper'

RSpec.describe UrlShortenerController, type: :request do

  describe 'post #new' do
    before { post '/', params: { url: 'http://farmdrop.com' } }
    it 'returns http success' do

      expect(response.content_type).to eq 'application/json; charset=utf-8'
    end

    it 'returns the short code and url' do
      expect(JSON.parse(response.body)['url']).to eq('http://farmdrop.com')
    end
  end

  describe 'get #index' do
    it 'returns http success' do
      get '/'

      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #code' do
    before do
      UrlShortenerService::URL_STORE = [{ short_url: 'abc123', url: 'http://farmdrop.com' }]
    end

    it 'returns http redirect' do
      get '/abc123'

      expect(response).to redirect_to('http://farmdrop.com')
    end
  end
end
