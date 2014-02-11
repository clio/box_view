require 'spec_helper'

describe BoxView::Api::Actions::Listable do
  let(:session) { double("BoxView::Api::Actions::Listable") }
  let(:subject) {
    d = DummyApi.new(session)
    d.extend(BoxView::Api::Actions::Listable)
    d
  }

  describe "#list" do
    let(:response) do
      [{ id: 1 }, { id: 2 }]
    end

    it "should return the correct data items" do
      session.stub(:get).and_return(response)
      records = subject.list
      expect(records.count).to eql(2)
      expect(records.first).to be_kind_of(DummyResource)
      expect(records.first.id).to eql(1)
      expect(records.last.id).to eql(2)
    end
  end

end