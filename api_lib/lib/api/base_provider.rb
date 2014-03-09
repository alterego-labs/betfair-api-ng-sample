class Api::BaseProvider

  def fetch(data: "", parameters: {}, sport: "")
    raise "Must be reimplemented!"
  end

private

  def build_function(method)
    "list#{method.to_s.pluralize.camelize}"
  end

end