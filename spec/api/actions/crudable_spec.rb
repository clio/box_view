require 'spec_helper'

describe BoxView::Api::Actions::Crudable do
  let(:session) { double("BoxView::Api::Actions::Crudable") }
  let(:params) { { text: "1" } }
  let(:subject) {
    d = DummyApi.new(session)
    d.extend(BoxView::Api::Actions::Crudable)
    d
  }
  let(:response) { { id: 1, text: "1"} }
  before { session.stub(:convert_params).and_return(params) }

  describe "#create" do
    it "should send a create request" do
      session.stub(:post).with("dummies", params.to_json).and_return(response)
      record = subject.create(params)
      expect(record).to be_kind_of(DummyResource)
      expect(record.id).to eql(1)
    end
  end

  describe "#update" do
    it "should send an update request" do
      session.stub(:put).with("dummies/1", params.to_json).and_return(response)
      record = subject.update(1, params)
      expect(record).to be_kind_of(DummyResource)
      expect(record.id).to eql(1)
    end
  end

  describe "#destroy" do
    it "should send a delete request" do
      session.should_receive(:delete)
      subject.destroy(1)
    end
  end
end