module WeburlHelper
  def url_with_protocol(weburl)
    /^http/.match(weburl) ? weburl : "http://#{weburl}"
  end
end