# BoxView

A ruby client for [Box's View API](http://developers.box.com/view/). 

## Installation

Add this line to your application's Gemfile:

    gem 'box_view'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install box_view

## Usage

Configure with your Box View API key.

    BoxView::Session.config do |config|
      config.box_view_token = YOUR_API_KEY
    end

Or configure a session and pass it to the API when you instatiate it.

    session = BoxView::Session.new(token: YOUR_API_KEY)
    BoxView::Api::Document.new(session)

Upload a document at a url.

    doc = BoxView::Api::Document.new.upload("http://www.example.com/myfile.pdf", "My File")

Check the document's `status`. When it is "done", you're ready to generate a viewing session.

    doc = doc.reload
    if doc.status == "done"
      document_session = doc.document_session
      view_url = document_session.view_url
    end

Remove the document from Box View.

    doc.destroy

List all of your Box View documents.

    docs = BoxView::Api::Document.new.list

Generate a thumbnail of a document

    f = File.open("myfile.pdf", 'w')
    f.write(doc.thumbnail(100, 100))
    f.flush
    f.close

Download the conents in pdf or zip format

    f = File.open("myfile.pdf", 'w')
    f.write(doc.content("pdf"))
    f.flush
    f.close

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
