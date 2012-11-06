module ArticletypesHelper

  def articletype_path(articletype)
    params ? articletype.code : publications_path
  end

end