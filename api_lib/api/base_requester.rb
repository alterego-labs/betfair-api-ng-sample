class Api::BaseRequester

  def load(parameters: {}, provider: "")
    raise "Must be reimplemented!"
  end

end