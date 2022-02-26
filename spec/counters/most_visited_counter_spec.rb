# frozen_string_literal: true

RSpec.describe SmartParser::Counters::MostVisitedCounter do
  let(:log) { build(:log) }
  let(:invalid_line) { 'invalid_line_for_the_default_regex' }

  context 'when using invalid lines' do
    before { subject.count(invalid_line) }

    describe '#to_a' do
      it { expect(subject.to_a).to match([]) }
    end

    describe '#count(line)' do
      it { expect(subject.count(invalid_line)).to be_falsy }
    end
  end

  context 'when using lines that matches with the default regex' do
    before { log.each { |line| subject.count(line) } }

    describe '#count(line)' do
      it { expect(subject.count(log.first)).to be_truthy }
      it { expect(subject.count('/path 127.0.0.1')).to be_truthy }
    end

    describe '#to_a' do
      it { expect(subject.to_a.size).to eq(4) }
      it { expect(subject.to_a.first.first).to eq('/home') }
      it { expect(subject.to_a.first[1]).to eq(20) }
      it { expect(subject.to_a[1][0]).to eq('/then/10') }
      it { expect(subject.to_a[1][1]).to eq(10) }
      it { expect(subject.to_a[2][0]).to eq('/five') }
      it { expect(subject.to_a[2][1]).to eq(5) }
      it { expect(subject.to_a.last[0]).to eq('/two/2') }
      it { expect(subject.to_a.last[1]).to eq(2) }
    end
  end
end
