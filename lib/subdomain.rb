class Subdomain
  def self.matches?(request)
    request.subdomain.present? and request.subdomain != "www" and request.subdomain != "beta"
  end
end