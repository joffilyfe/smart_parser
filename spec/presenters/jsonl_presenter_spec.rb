# frozen_string_literal: true

RSpec.describe SmartParser::Presenters::JSONLPresenter do
  subject { SmartParser::Presenters::JSONLPresenter }
  let(:rows) { [['/home', 4], ['/index', 3], ['/noop', 1]] }
  let(:expected_str) do
    "{\"path\":\"/home\",\"visits\":4,\"description\":\"Simple Presenter\"}\n" \
      "{\"path\":\"/index\",\"visits\":3,\"description\":\"Simple Presenter\"}\n" \
      "{\"path\":\"/noop\",\"visits\":1,\"description\":\"Simple Presenter\"}\n"
  end

  describe '#present(rows, description)' do
    it { expect(subject.present(rows, 'Simple Presenter')).to eq(expected_str) }
  end
end
