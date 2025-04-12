# frozen_string_literal: true

RSpec.describe JokeApi::Client do
  let(:client) { described_class.new }

  describe '#random_joke' do
    subject { client.random_joke }

    it { is_expected.to eq 'random_joke' }
  end
end
