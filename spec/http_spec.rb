require 'spec_helper'

describe BoxView::Http do
  let(:http) { BoxView::Session.new }

  describe "#parse_response" do
    context "when given ill-formed JSON" do
      let(:response) { response = double("Net::HTTPResponse", body: "foo") }
      
      it "should return nil" do
        expect(http.parse_response(response)).to be_nil
      end
    end
  end
end