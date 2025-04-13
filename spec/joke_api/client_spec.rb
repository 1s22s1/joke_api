# frozen_string_literal: true

RSpec.describe JokeApi::Client do
  let(:client) { described_class.new }

  describe '#random_joke' do
    before do
      body = '{"type":"general","setup":"Where do hamburgers go to dance?","punchline":"The meat-ball.","id":285}'

      stub_request(:get, "#{described_class::BASE_URL}/random_joke")
        .to_return body: body, headers: { content_type: 'application/json' }
    end

    it do
      expected_response = described_class::JokeResponse.new(id: 285, type: 'general',
                                                            setup: 'Where do hamburgers go to dance?', punchline: 'The meat-ball.')
      actual_response = client.random_joke

      expect(actual_response).to eq expected_response
    end
  end
end
