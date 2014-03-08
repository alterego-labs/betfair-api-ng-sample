class Api::BaseProvider

  def fetch(function: "", parameters: {}, sport: "")
    raise "Must be reimplemented!"
  end

end