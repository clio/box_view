require "box_view/version"

require "net/http"
require "json"

module BoxView
  {
    Session: 'session',
    Http:    'http'
  }.each_pair do |klass, file|
    autoload klass, "box_view/#{file}"
  end

  {
    Base:            'base',
    Document:        'document',
    DocumentSession: 'document_session'
  }.each_pair do |klass, file|
    autoload klass, "box_view/models/#{file}"
  end

  module Api
    {
      Base:            'base',
      Document:        'document',
      DocumentSession: 'document_session'
    }.each_pair do |klass, file|
      autoload klass, "box_view/api/#{file}"
    end
  end
end
