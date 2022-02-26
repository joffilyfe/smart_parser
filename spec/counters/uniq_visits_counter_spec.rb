# frozen_string_literal: true

RSpec.describe SmartParser::Counters::UniqVisitorsCounter do
  let(:log) { build(:log) }
  let(:invalid_line) { 'invalid_line_for_the_default_regex' }

  describe '#description' do
    it { expect(subject.description).to eq('Unique visitors') }
  end

  context 'when using invalid lines for the default regex' do
    before { subject.count(invalid_line) }

    describe '#count(line)' do
      it { expect(subject.count(invalid_line)).to be_falsy }
    end
  end

  context 'when using lines that matches with the default regex' do
    let(:expected_array) { [['/two/2', 2], ['/then/10', 1], ['/home', 1], ['/five', 1]] }
    before { log.each { |line| subject.count(line) } }

    describe '#count(line)' do
      it { expect(subject.count(log.first)).to be_truthy }
    end

    describe '#to_a' do
      it { expect(subject.to_a.size).to eq(4) }
      it { expect(subject.to_a.first.first).to eq('/two/2') }
      it { expect(subject.to_a.first[1]).to eq(2) }
      it { expect(subject.to_a).to match_array(expected_array) }
    end
  end
end
