class DummyResource < BoxView::Models::Base

  has_attributes(
    id: { type: :integer },
    text: { type: :string }
  )

  def to_params
    { text: self.text }
  end

  def api
    DummyApi.new(session)
  end

end