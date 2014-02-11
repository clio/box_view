require 'spec_helper'

describe BoxView::Session do
  let(:session) { BoxView::Session.new(credentials) }
  let(:credentials) { {} }
  let(:config_token) { "ABC123" }
  before { BoxView::Session.config { |config| config.box_view_token = config_token } }

  it "should pick up the configured token" do
    expect(session.token).to eql(config_token)
  end

  context "when credentials are supplied" do
    let(:credentials) { { token: override_token } }
    let(:override_token) { "overridden token" }

    it "should use the token passed in" do
      expect(session.token).to eql(override_token)
    end
  end
end