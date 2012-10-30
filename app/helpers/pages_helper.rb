module PagesHelper

  def page_path(page)

    if page.kind_of?(String)
      url_for(:url => page, :subdomain => false)
    elsif page.kind_of?(Hash)
      url_for(page)
    else
      url_for(:url => page.slug, :subdomain => page.project ? page.project.subdomain : false)
    end
  end

end