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

  describe '#random_ten' do
    let(:expected_response) do
      [
        described_class::JokeResponse.new(
          id: 353,
          type: 'general',
          setup: 'Why do trees seem suspicious on sunny days?',
          punchline: 'Dunno, they\'re just a bit shady.'
        ),
        described_class::JokeResponse.new(
          id: 345,
          type: 'general',
          setup: 'Why do choirs keep buckets handy?',
          punchline: 'So they can carry their tune'
        ),
        described_class::JokeResponse.new(
          id: 147,
          type: 'general',
          setup: 'Is there a hole in your shoe?',
          punchline: 'No… Then how’d you get your foot in it?'
        ),
        described_class::JokeResponse.new(
          id: 245,
          type: 'general',
          setup: '"What is the hardest part about sky diving?',
          punchline: 'The ground.'
        ),
        described_class::JokeResponse.new(
          id: 435,
          type: 'programming',
          setup: 'What do you call a computer mouse that swears a lot??',
          punchline: 'A cursor!'
        ),
        described_class::JokeResponse.new(
          id: 118,
          type: 'general',
          setup: 'How do hens stay fit?',
          punchline: 'They always egg-cercise!'
        ),
        described_class::JokeResponse.new(
          id: 421,
          type: 'general',
          setup: 'Why couldn\'t the bicycle stand up by itself?',
          punchline: 'It was two-tired.'
        ),
        described_class::JokeResponse.new(
          id: 420,
          type: 'programming',
          setup: 'Why was the JavaScript developer sad?',
          punchline: 'He didn\'t know how to null his feelings.'
        ),
        described_class::JokeResponse.new(
          id: 312,
          type: 'general',
          setup: 'Why did Dracula lie in the wrong coffin?',
          punchline: 'He made a grave mistake.'
        ),
        described_class::JokeResponse.new(
          id: 385,
          type: 'general',
          setup: 'How do you make the number one disappear?',
          punchline: 'Add the letter G and it’s “gone”!'
        )
      ]
    end

    before do
      body = File.read('spec/data/random_ten.dat')

      stub_request(:get, "#{described_class::BASE_URL}/random_ten")
        .to_return body: body, headers: { content_type: 'application/json' }
    end

    it do
      expect(client.random_ten).to eq expected_response
    end
  end
end
