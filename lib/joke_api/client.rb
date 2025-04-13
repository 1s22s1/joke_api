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

    class TooBigId < StandardError; end

    def random_joke
      body = connection.get('/random_joke').body

      parse_joke_response(body)
    end

    def jokes_random
      body = connection.get('/jokes/random').body

      parse_joke_response(body)
    end

    def types
      connection.get('/types').body
    end

    def random_ten
      body = connection.get('/random_ten').body

      body.map { |joke| parse_joke_response(joke) }
    end

    def jokes_ten
      body = connection.get('/jokes/ten').body

      body.map { |joke| parse_joke_response(joke) }
    end

    def random(number)
      Integer(number)

      response = connection.get("/jokes/random/#{number}")

      raise TooBigId, response.body if response.headers.fetch('content-type') == 'application/text'

      response.body.map { |joke| parse_joke_response(joke) }
    end

    %w[general programming dad].each do |type|
      define_method "#{type}_random" do
        body = connection.get("/jokes/#{type}/random").body

        parse_joke_response(body[0])
      end
    end

    def knock_knock_random
      body = connection.get('/jokes/knock-knock/random').body

      parse_joke_response(body[0])
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
