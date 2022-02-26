# frozen_string_literal: true

RSpec.describe SmartParser::Counters::Counter do
  it { expect { subject.to_a }.to raise_error(NotImplementedError) }
  it { expect { subject.description }.to raise_error(NotImplementedError) }
  it { expect { subject.count('') }.to raise_error(NotImplementedError) }
end
