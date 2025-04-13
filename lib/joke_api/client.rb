# frozen_string_literal: true

require 'faraday'

module JokeApi
  # API Client for Joke API
  class Client
    BASE_URL = 'https://official-joke-api.appspot.com'

    # Response class
    class JokeResponse
      include Comparable

      attr_reader :id, :type, :setup, :punchline

      def initialize(id:, type:, setup:, punchline:)
        @id = id
        @type = type
        @setup = setup
        @punchline = punchline
      end

      def <=>(other)
        @id <=> other.id && @type <=> other.type && @setup <=> other.setup && @punchline <=> other.punchline
      end
    end

    def random_joke
      body = connection.get('/random_joke').body

      parse_joke_response(body)
    end

    def jokes_random
      body = connection.get('/jokes/random').body

      parse_joke_response(body)
    end

    private

    def connection
      @connection ||= Faraday.new(BASE_URL) do |builder|
        builder.response :json
      end
    end

    def parse_joke_response(body)
      JokeResponse.new(
        id: body.fetch('id'),
        type: body.fetch('type'),
        setup: body.fetch('setup'),
        punchline: body.fetch('punchline')
      )
    end
  end
end
