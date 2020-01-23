require 'rails_helper'

describe UrlShortenerService do
  describe '#shorten' do
    subject { described_class.new.shorten(url: url) }

    context 'with a url' do
      context 'with a new url' do
        context 'with a well formed url' do
          let(:url) { 'http://farmdrop.com' }

          it 'returns the shortened url' do
            expect(subject).to match(/[a-z]{3}[0-9]{3}/)
          end

          it 'stores the shortened url and code' do
            expect(URL_STORE.find { |u| u[:code] == subject }[:url]).to eq(url)
          end
        end

        context 'with a url missing http' do
          let(:url) { 'farmdrop.com' }

          it 'returns the shortened url' do
            expect(subject).to match(/[a-z]{3}[0-9]{3}/)
          end

          it 'stores the shortened url and code' do
            expect(URL_STORE.find { |u| u[:code] == subject }[:url]).to eq('http://' + url)
          end
        end
      end

      context 'with existing shortened urls' do
        before { described_class.new.shorten(url: 'http://farmdrop.com') }
        let(:url) { 'http://somerealsite.com/' }

        it 'returns the shortened url' do
          expect(subject).to match(/[a-z]{3}[0-9]{3}/)
        end

        it 'stores the shortened url and code' do
          expect(URL_STORE.find { |u| u[:code] == subject }[:url]).to eq(url)
        end

        context 'with multiple attempts to shorten the same url' do
          before { described_class.new.shorten(url: 'http://farmdrop.com') }
          before { described_class.new.shorten(url: 'http://farmdrop.com') }
          before { described_class.new.shorten(url: 'http://farmdrop.com') }
          let(:url) { 'http://farmdrop.com' }

          it 'returns the shortened url' do
            expect(subject).to match(/[a-z]{3}[0-9]{3}/)
          end

          it 'only stores the url once' do
            urls = URL_STORE.map(&:values).flatten
            expect(urls).to include(url)
            expect(urls.select { |u| u == url }.count).to eq(1)
          end
        end
      end
    end
  end
end
