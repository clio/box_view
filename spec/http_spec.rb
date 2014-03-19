require 'spec_helper'

describe BoxView::Http do
  let(:http) { BoxView::Session.new }

  describe "#parse_response" do
    context "when given ill-formed JSON" do
      let(:response) { double("Net::HTTPResponse", body: "foo") }

      it "should return nil" do
        expect(http.parse_response(response)).to be_nil
      end
    end
  end

  describe '#check_for_error' do
    let(:response) { }
    subject { http.check_for_error(response) }

    context 'given a 202 response' do
      let(:response) { Net::HTTPAccepted.new('1.1', '202', 'ACCEPTED') }

      context 'that does not have a Retry-After header' do
        it 'should not raise an error' do
          expect { subject }.not_to raise_error
        end
      end

      context 'that does have a Retry-After header' do
        let(:response) { super().tap { |r| r['Retry-After'] = '10' } }
        it 'should raise a BoxView::Http:RetryNeeded' do
          expect { subject }.to raise_error(BoxView::Http::RetryNeededError) do |error|
            error.retry_after.should == '10'
          end
        end
      end
    end

    context 'given a 400 response' do
      let(:body) { }
      let(:response) do
        Net::HTTPBadRequest.new('1.1', '400', 'BAD REQUEST').tap do |r|
          r.stub(:body).and_return(body)
        end
      end

      context 'without a parseable error message' do
        let(:body) { 'NOT JSON' }

        it 'should raise a BoxView::Http:BadRequest' do
          expect { subject }.to raise_error(BoxView::Http::BadRequestError)
        end
      end

      context 'with a parseable error message' do
        let(:body) do
          '{"message": "Bad request",
            "type": "error",
            "details": [{"field": "height",
                         "message": "Ensure this value is less than or equal to 768."}],
            "request_id": "999605a17b974850baaccbe2ae479c75"}'
        end

        it 'should raise a BoxView::Http:BadRequest with a message indicating the problem' do
          expect { subject }.to raise_error(BoxView::Http::BadRequestError, /height/)
        end
      end
    end
  end
end
