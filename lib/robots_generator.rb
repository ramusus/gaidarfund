class RobotsGenerator
  # Use the config/robots.txt in production.
  # Disallow everything for all other environments.
  def self.call(env)
    request = ActionDispatch::Request.new(env)
    headers = {}
    project = Project.find_by_subdomain(request.subdomain)
    default = File.read Rails.root.join('config', 'robots.txt')
    body =
      if project and not request.subdomain.empty?
        project.robots_txt.empty? ? default : project.robots_txt
      else
        chunk = Chunk.find_by_code('robots_txt')
        chunk ? chunk.content : default
      end

    [200, headers, [body]]
  rescue Errno::ENOENT
    [404, {}, "User-agent: *\nDisallow: /"]
  end
end