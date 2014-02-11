class DummyApi < BoxView::Api::Base
  
  def data_klass
    DummyResource
  end

  def endpoint_url; "dummies"; end
  
end