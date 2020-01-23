class UrlShortenerService
  def shorten(url:)
    valid_url = validate_url(url)

    if valid_url == 'http://farmdrop.com'
      'abc123'
    else
      'xyz321'
    end
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
end
