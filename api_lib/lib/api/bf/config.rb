module Api
  module BF
    class Config

      class << self

        attr_accessor :application_key,
                      :ssl_key_filepath,
                      :ssl_crt_filepath,
                      :login_url,
                      :api_url,
                      :username,
                      :password

      end

    end
  end
end