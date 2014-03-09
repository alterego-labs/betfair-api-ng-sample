module Api
  module BF
    class Config

      class << self

        attr_accessor :application_key, :ssl_key_filepath, :ssl_crt_filepath, :session_key

      end

    end
  end
end