require 'spec_helper.rb'

describe BoxView::Models::Base do
  let(:model) { BoxView::Models::Base.new(fields, session) }
  let(:fields) { {} }
  let(:session) { nil }

  before {
    model.stub(:api).and_return(BoxView::Api::Base.new)
    model.stub(:to_params).and_return({})
    model.stub(:id).and_return(1)
  }

  describe "#reload" do
    context "when the resource is not saved" do
      before { model.stub(:id) }
      it "should raise ResourceNotSaved" do
        expect{model.reload}.to raise_error(BoxView::Models::ResourceNotSaved)
      end
    end

    it "should use the api's find method" do
      model.api.should_receive(:find)
      model.reload
    end
  end

  describe "#save" do
    context "when the resource is not saved" do
      before {
        model.stub(:id)
        model.api.stub(:create).and_return(double("BoxView::Models::Base", id: 1))
      }
      it "should use the api's create method" do
        model.api.should_receive(:create)
        model.should_receive(:id=)
        model.save
      end
    end

    it "should use the api's update method" do
      model.api.should_receive(:update)
      model.save
    end
  end

  describe "#destroy" do
    context "when the resource is not saved" do
      before { model.stub(:id) }
      it "should raise ResourceNotSaved" do
        expect{model.destroy}.to raise_error(BoxView::Models::ResourceNotSaved)
      end
    end

    it "should use the api's destroy method" do
      model.api.should_receive(:destroy)
      model.destroy
    end
  end

  describe ".has_attributes" do
    before do
      BoxView::Models::Base.has_attributes(
        foo: { type: :string, readonly: true },
        bar: { type: :string }
      )
    end
    let(:model) { BoxView::Models::Base.new({foo: "foo"}) }

    it "should define getter for the given attributes" do
      model.should respond_to :foo
    end

    it "should define setter for the given attributes" do
      model.should respond_to :foo=
    end

    context "when an attribute is readonly" do
      it "should create setter that throws an exception" do
        expect{model.foo = "bar"}.to raise_error(BoxView::Models::ReadOnlyAttribute)
      end
    end

    it "should convert the attribute when setting it" do
      BoxView::Models::Base.should_receive :convert_attribute
      model.bar = "bar"
    end
  end

  describe ".convert_attribute" do
    let(:result) { BoxView::Models::Base.convert_attribute(value, type) }

    context "when type is date" do
      let(:type) { :date }
      let(:value) { "2014-02-11" }
      
      context "when value is a Time" do
        let(:value) { Time.new }
        
        it "should call to_date on the value" do
          value.should_receive(:to_date)
          result
        end
      end

      context "when value is a DateTime" do
        let(:value) { DateTime.new }
        
        it "should call to_date on the value" do
          value.should_receive(:to_date)
          result
        end
      end

      it "should parse the value" do
        Date.should_receive(:parse).with(value)
        result
      end
    end

    context "when type is time" do
      let(:type) { :time }
      let(:value) { "15:00:00" }
      
      context "when value is a Date" do
        let(:value) { Date.new }
        
        it "should call to_time on the value" do
          value.should_receive(:to_time)
          result
        end
      end

      context "when value is a DateTime" do
        let(:value) { DateTime.new }
        
        it "should call to_time on the value" do
          value.should_receive(:to_time)
          result
        end
      end

      it "should parse the value" do
        Time.should_receive(:parse).with(value)
        result
      end
    end

    context "when type is datetime" do
      let(:type) { :datetime }
      let(:value) { "15:00:00" }
      
      context "when value is a Date" do
        let(:value) { Date.new }
        
        it "should call to_datetime on the value" do
          value.should_receive(:to_datetime)
          result
        end
      end

      context "when value is a DateTime" do
        let(:value) { DateTime.new }
        
        it "should call to_datetime on the value" do
          value.should_receive(:to_datetime)
          result
        end
      end

      it "should parse the value" do
        DateTime.should_receive(:parse).with(value)
        result
      end
    end

    context "when type is integer" do
      let(:type) { :integer }
      let(:value) { "42" }
      
      it "should convert the value to an integer" do
        expect(result).to eql(42)
      end
    end

    context "when type is string" do
      let(:type) { :string }
      let(:value) { 42 }
      
      it "should convert the value to a string" do
        expect(result).to eql("42")
      end
    end

    context "when type is anything else" do
      let(:type) { :foo }
      let(:value) { [1, 2, 3] }
      
      it "should pass the value through" do
        expect(result).to eql(value)
      end

    end
  end

end