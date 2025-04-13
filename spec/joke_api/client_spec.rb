# frozen_string_literal: true

RSpec.describe JokeApi::Client do
  let(:client) { described_class.new }

  context 'when grab a random joke' do
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

      stub_request(:get, "#{described_class::BASE_URL}/#{path}")
        .to_return body: body, headers: { content_type: 'application/json' }
    end

    describe '#random_joke' do
      let(:path) { 'random_joke' }

      it do
        expect(client.random_joke).to eq expected_response
      end
    end

    describe '#jokes_random' do
      let(:path) { 'jokes/random' }

      it do
        expect(client.jokes_random).to eq expected_response
      end
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

  context 'when grab ten random jokes' do
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

      stub_request(:get, "#{described_class::BASE_URL}/#{path}")
        .to_return body: body, headers: { content_type: 'application/json' }
    end

    describe '#random_ten' do
      let(:path) { 'random_ten' }

      it do
        expect(client.random_ten).to eq expected_response
      end
    end

    describe '#jokes_ten' do
      let(:path) { 'jokes/ten' }

      it do
        expect(client.jokes_ten).to eq expected_response
      end
    end
  end

  describe '#random' do
    context 'when id = 1' do
      let(:expected_response) do
        [
          described_class::JokeResponse.new(
            id: 27,
            type: 'programming',
            setup: 'To understand what recursion is...',
            punchline: 'You must first understand what recursion is'
          )
        ]
      end

      before do
        body = File.read('spec/data/random_one.dat')

        stub_request(:get, "#{described_class::BASE_URL}/jokes/random/1")
          .to_return body: body, headers: { content_type: 'application/json' }
      end

      it do
        expect(client.random(1)).to eq expected_response
      end
    end

    context 'when id = a' do
      before do
        body = 'The passed path is not a number.'

        stub_request(:get, "#{described_class::BASE_URL}/jokes/random/1")
          .to_return body: body, status: 304, headers: { content_type: 'application/text' }
      end

      it do
        expect { client.random('a') }.to raise_error(ArgumentError)
      end
    end

    context 'when id = 1000' do
      before do
        body = 'The passed path exceeds the number of jokes (451).'

        stub_request(:get, "#{described_class::BASE_URL}/jokes/random/1000")
          .to_return body: body, headers: { content_type: 'application/text' }
      end

      it do
        expect { client.random(1000) }.to raise_error(described_class::TooBigId)
      end
    end
  end

  describe '#general_random' do
    let(:expected_response) do
      described_class::JokeResponse.new(
        id: 428,
        type: 'general',
        setup: 'Why did the chicken cross the playground?',
        punchline: 'To get to the other slide.'
      )
    end

    before do
      body = File.read('spec/data/general_random.dat')

      stub_request(:get, "#{described_class::BASE_URL}/jokes/general/random")
        .to_return body: body, headers: { content_type: 'application/json' }
    end

    it do
      expect(client.general_random).to eq expected_response
    end
  end

  describe '#knock_knock_random' do
    let(:expected_response) do
      described_class::JokeResponse.new(
        id: 12,
        type: 'knock-knock',
        setup: 'Knock knock. \n" + " Who\'s there? \n" + " Cows go. \n" + " Cows go who?',
        punchline: 'No, cows go moo.'
      )
    end

    before do
      body = File.read('spec/data/knock-knock_random.dat')

      stub_request(:get, "#{described_class::BASE_URL}/jokes/knock-knock/random")
        .to_return body: body, headers: { content_type: 'application/json' }
    end

    it do
      expect(client.knock_knock_random).to eq expected_response
    end
  end

  describe '#programming_random' do
    let(:expected_response) do
      described_class::JokeResponse.new(
        id: 440,
        type: 'programming',
        setup: 'Why don\'t programmers like nature?',
        punchline: 'Too many bugs.'
      )
    end

    before do
      body = File.read('spec/data/programming_random.dat')

      stub_request(:get, "#{described_class::BASE_URL}/jokes/programming/random")
        .to_return body: body, headers: { content_type: 'application/json' }
    end

    it do
      expect(client.programming_random).to eq expected_response
    end
  end

  describe '#dad_random' do
    let(:expected_response) do
      described_class::JokeResponse.new(
        id: 378,
        type: 'dad',
        setup: 'Why do fathers take an extra pair of socks when they go golfing?',
        punchline: 'In case they get a hole in one!'
      )
    end

    before do
      body = File.read('spec/data/dad_random.dat')

      stub_request(:get, "#{described_class::BASE_URL}/jokes/dad/random")
        .to_return body: body, headers: { content_type: 'application/json' }
    end

    it do
      expect(client.dad_random).to eq expected_response
    end
  end

  describe '#general_ten' do
    before do
      body = File.read('spec/data/general_ten.dat')

      stub_request(:get, "#{described_class::BASE_URL}/jokes/general/ten")
        .to_return body: body, headers: { content_type: 'application/json' }
    end

    it do
      expect(client.general_ten.length).to eq 10
    end
  end

  describe '#knock_knock_ten' do
    before do
      body = File.read('spec/data/knock-knock_ten.dat')

      stub_request(:get, "#{described_class::BASE_URL}/jokes/knock-knock/ten")
        .to_return body: body, headers: { content_type: 'application/json' }
    end

    it do
      expect(client.knock_knock_ten.length).to eq 5
    end
  end

  describe '#programming_ten' do
    before do
      body = File.read('spec/data/programming_ten.dat')

      stub_request(:get, "#{described_class::BASE_URL}/jokes/programming/ten")
        .to_return body: body, headers: { content_type: 'application/json' }
    end

    it do
      expect(client.programming_ten.length).to eq 10
    end
  end

  describe '#dad_ten' do
    before do
      body = File.read('spec/data/dad_ten.dat')

      stub_request(:get, "#{described_class::BASE_URL}/jokes/dad/ten")
        .to_return body: body, headers: { content_type: 'application/json' }
    end

    it do
      expect(client.dad_ten.length).to eq 2
    end
  end
end
