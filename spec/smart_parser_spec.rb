# frozen_string_literal: true

RSpec.describe SmartParser::Parser do
  subject { SmartParser::Parser.new(lines: log, counters: counters) }
  let(:log) { build(:log) }
  let(:counters) { [SmartParser::Counters::MostVisitedCounter.new] }

  it { expect(subject.lines.size).to eq(37) }

  describe '#parse!' do
    it { expect(subject.parse!).to be_truthy }

    context 'when calling more than once' do
      before { subject.parse! }

      it { expect(subject.parse!).to be_falsy }
    end
  end

  describe '#counters_results' do
    let(:results) do
      [{ data: [['/home', 20], ['/then/10', 10], ['/five', 5], ['/two/2', 2]], description: 'Most visited' }]
    end

    before { subject.parse! }

    it { expect(subject.counters_results).to eq(results) }
  end

  describe '#present' do
    before { subject.parse! }
    let(:stdout) { "Most visited\n/home 20 visits\n/then/10 10 visits\n/five 5 visits\n/two/2 2 visits\n\n" }

    it { expect { subject.present }.to output(stdout).to_stdout }
  end

  context 'when none counters are added to the Parser' do
    let(:counters) { [] }

    it { expect(subject.parse!).to be_falsy }

    describe '#counters_results' do
      before { subject.parse! }

      it { expect(subject.counters_results).to eq([]) }
    end
  end

  context 'when none lines are added to the parser' do
    let(:log) { [] }

    it { expect(subject.parse!).to be_falsy }

    describe '#counters_results' do
      before { subject.parse! }

      it { expect(subject.counters_results).to eq([{ data: [], description: 'Most visited' }]) }
    end

    describe '#present' do
      it { expect { subject.present }.to output(nil).to_stdout }
    end
  end
end
