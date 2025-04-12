# frozen_string_literal: true

require 'faraday'

module JokeApi
  # API Client for Joke API
  class Client
    BASE_URL = 'https://official-joke-api.appspot.com'

    # Response class
    class JokeResponse
      include Comparable

      attr_reader :id, :type

      def initialize(id:, type:)
        @id = id
        @type = type
      end

      def <=>(other)
        @id <=> other.id && @type <=> other.type
      end
    end

    def random_joke
      body = connection.get('/random_joke').body

      JokeResponse.new(id: body.fetch('id'), type: body.fetch('type'))
    end

    private

    def connection
      @connection ||= Faraday.new(BASE_URL) do |builder|
        builder.response :json
      end
    end
  end
end
