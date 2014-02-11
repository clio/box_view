require 'spec_helper'

describe BoxView::Api::Actions::Findable do
  let(:session) { double("BoxView::Api::Actions::Findable") }
  let(:subject) {
    d = DummyApi.new(session)
    d.extend(BoxView::Api::Actions::Findable)
    d
  }

  describe "#find" do
    let(:response) do
      { id: 1 }
    end

    it "should return the correct data item" do
      session.stub(:get).and_return(response)
      record = subject.find(1)
      expect(record).to be_kind_of(DummyResource)
      expect(record.id).to eql(1)
    end
  end
end