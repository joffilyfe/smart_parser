# frozen_string_literal: true

RSpec.describe SmartParser::Presenters::LinePresenter do
  subject { SmartParser::Presenters::LinePresenter }
  let(:rows) { [['/home', 3], ['/index', 2], ['/noop', 1]] }
  let(:expected_str) { "Simple Presenter\n/home 3 visits\n/index 2 visits\n/noop 1 visits\n" }

  describe '#present(rows, title)' do
    it { expect(subject.present(rows, 'Simple Presenter')).to eq(expected_str) }
  end
end
