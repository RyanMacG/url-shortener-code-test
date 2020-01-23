URL_STORE = []

class UrlShortenerService
  def shorten(url:)
    valid_url = validate_url(url)
    stored_url = URL_STORE.find { |u| u[:url] == valid_url }

    if stored_url.present?
      code = stored_url[:code]
    else
      code = generate_short_code
      URL_STORE << { code: code, url: valid_url }
    end

    code
  end

  private

  def validate_url(url)
    uri = URI.parse(url)
    if uri.kind_of?(URI::HTTP) || uri.kind_of?(URI::HTTPS)
      url
    else
      'http://' + url
    end
  end

  def generate_short_code
    code = /[a-z]{3}[0-9]{3}/.random_example
    generate_short_code if URL_STORE.map(&:keys).include?(code)
    code
  end
end
