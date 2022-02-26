# frozen_string_literal: true

RSpec.describe SmartParser::Presenters::TablePresenter do
  subject { SmartParser::Presenters::TablePresenter }
  let(:rows) { [['/home', 3], ['/index', 2], ['/noop', 1]] }
  let(:expected_str) do
    "+----------------+
|  simple table  |
+--------+-------+
| Path   | Count |
+--------+-------+
| /home  | 3     |
| /index | 2     |
| /noop  | 1     |
+--------+-------+"
  end

  describe '#present(rows, description)' do
    it { expect(subject.present(rows, 'simple table')).to eq(expected_str) }
  end
end
