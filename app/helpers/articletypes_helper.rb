module ArticletypesHelper

  def articletype_path(articletype)
    params = Articletype::ROUTES_MAP[articletype.id]
    params ? params[0] : publications_path
  end

end