require 'rails_helper'

describe UrlShortenerService do
  describe '#shorten' do
    subject { described_class.new.shorten(url: url) }

    context 'with a url' do
      context 'with a new url' do
        context 'with a well formed url' do
          let(:url) { 'http://farmdrop.com' }

          it 'returns the shortened url' do
            expect(subject).to eq('abc123')
          end
        end

        context 'with a url missing http' do
          let(:url) { 'farmdrop.com' }

          it 'returns the shortened url' do
            expect(subject).to eq('abc123')
          end
        end
      end

      context 'with existing shortened urls' do
        before { described_class.new.shorten(url: 'http://farmdrop.com') }
        let(:url) { 'http://somerealsite.com/' }

        it 'returns the shortened url' do
          expect(subject).to eq('xyz321')
        end
      end
    end
  end
end
