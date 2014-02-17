require 'spec_helper'

describe BoxView::Api::Document do
  let(:session) { double("BoxView::Api::Session") }
  let(:url) { "http://www.example.com/1.pdf" }
  let(:name) { "Doc 1" }
  let(:params) { { url: url, name: name } }
  let(:subject) { BoxView::Api::Document.new(session) }
  
  describe "#upload" do
    let(:response) { { id: "1" } }

    it "should send a post request" do
      session.stub(:post).with("documents", params.to_json).and_return(response)
      record = subject.upload(url, name)
      expect(record).to be_kind_of(BoxView::Models::Document)
      expect(record.id).to eql("1")
    end
  end

  describe "#content" do
    context "filename has invalid extension" do
      it "should raise an ArgumentError" do
        expect{subject.content("1", "foo.bar")}.to raise_error(ArgumentError)
      end
    end
  end
end