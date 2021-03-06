module UrlHelper
  def with_subdomain(subdomain)
    subdomain = (subdomain || "")
    subdomain += "." unless subdomain.empty?
    [subdomain, request.domain || 'gaidarfund.ru'].join
  end

  def url_for(options = nil)
    url = ''
    if options.kind_of?(Hash)
      if options.has_key?(:url)
        options[:trailing_slash] = false
        options[:controller] = "application"
        options[:action] = "index"
        options[:use_route] = "root"
        url = options.delete(:url).gsub(/^\//, "")
      end
      if options.has_key?(:subdomain)
        options[:host] = with_subdomain(options.delete(:subdomain))
        options[:only_path] = false
      end
    end
    super + url
  end
end