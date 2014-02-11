require 'spec_helper'

describe BoxView::Api::Base do
  let(:api) { BoxView::Api::Base.new(session) }
  let(:session) { nil }

  it "should ues the configured session" do
    expect(api.session).to_not be_nil
  end

  context "when a session is suppied" do
    let(:session) { "the session" }

    it "should use the supplied session" do
      expect(api.session).to eql(session)
    end
  end
end