# frozen_string_literal: true

RSpec.describe JokeApi::Client do
  let(:client) { described_class.new }

  describe '#random_joke' do
    let(:expected_response) do
      described_class::JokeResponse.new(
        id: 285,
        type: 'general',
        setup: 'Where do hamburgers go to dance?',
        punchline: 'The meat-ball.'
      )
    end

    before do
      body = '{"type":"general","setup":"Where do hamburgers go to dance?","punchline":"The meat-ball.","id":285}'

      stub_request(:get, "#{described_class::BASE_URL}/random_joke")
        .to_return body: body, headers: { content_type: 'application/json' }
    end

    it do
      expect(client.random_joke).to eq expected_response
    end
  end

  describe '#jokes_random' do
    let(:expected_response) do
      described_class::JokeResponse.new(
        id: 285,
        type: 'general',
        setup: 'Where do hamburgers go to dance?',
        punchline: 'The meat-ball.'
      )
    end

    before do
      body = '{"type":"general","setup":"Where do hamburgers go to dance?","punchline":"The meat-ball.","id":285}'

      stub_request(:get, "#{described_class::BASE_URL}/jokes/random")
        .to_return body: body, headers: { content_type: 'application/json' }
    end

    it do
      expect(client.jokes_random).to eq expected_response
    end
  end

  describe '#types' do
    before do
      body = '["general","knock-knock","programming","dad"]'

      stub_request(:get, "#{described_class::BASE_URL}/types")
        .to_return body: body, headers: { content_type: 'application/json' }
    end

    it do
      expect(client.types).to match %w[general knock-knock programming dad]
    end
  end
end
