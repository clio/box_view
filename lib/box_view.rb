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

  module Models
    {
      Base:            'base',
      Document:        'document',
      DocumentSession: 'document_session'
    }.each_pair do |klass, file|
      autoload klass, "box_view/models/#{file}"
    end
  end

  module Api
    {
      Base:            'base',
      Document:        'document',
      DocumentSession: 'document_session'
    }.each_pair do |klass, file|
      autoload klass, "box_view/api/#{file}"
    end

    module Actions
      {
        Crudable: 'crudable',
        Findable: 'findable',
        Listable: 'listable'
      }.each_pair do |klass, file|
        autoload klass, "box_view/api/actions/#{file}"
      end
    end
  end
end
