require 'spec_helper'

describe BoxView::Models::Document do
  let(:document) { BoxView::Models::Document.new }
  let(:api) { BoxView::Api::Document.new }
  before { document.stub(:api).and_return(api) }

  describe "#document_session" do
    before do
      BoxView::Api::DocumentSession.any_instance.stub(:create).and_return(BoxView::Models::DocumentSession.new)
    end

    context "when a document session has already been created" do
      before do
        document.instance_variable_set("@document_session", BoxView::Models::DocumentSession.new)
      end

      it "should not use DocumentSession api's create method" do
        BoxView::Api::DocumentSession.any_instance.should_not_receive(:create)
        document.document_session
      end
    end

    it "should use DocumentSession api's create method" do
      BoxView::Api::DocumentSession.any_instance.should_receive(:create)
      document.document_session
    end
  end

  describe "#thumbnail" do
    before { document.api.stub(:thumbnail) }
    it "should use the api's thumbnail method" do
      document.api.should receive(:thumbnail)
      document.thumbnail(100, 100)
    end
  end

  describe "#content" do
    before { document.api.stub(:content) }
    it "should use the api's content method" do
      document.api.should receive(:content)
      document.content
    end
  end
end