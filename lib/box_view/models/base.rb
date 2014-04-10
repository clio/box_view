require 'date'

module BoxView
  module Models

    class ReadOnlyAttribute < BoxView::Error; end
    class ResourceNotSaved < BoxView::Error; end

    class Base

      require 'time'

      attr_accessor :session

      def initialize(fields = {}, session = nil)
        self.session = session
        fields.each_pair do |k, v|
          self.send("#{k}=", v) if self.respond_to?("#{k}=") && !v.nil?
        end
      end

      def write_attribute(name, value)
        instance_variable_set("@#{name}", value)
      end

      def reload
        raise ResourceNotSaved.new if self.id.nil?
        api.find(self.id)
      end

      def save
        if self.id.nil?
          created_item = api.create(self.to_params)
          self.id = created_item && created_item.id
          self
        else
          api.update(self.id, self.to_params)
          self
        end
      end

      def destroy
        raise ResourceNotSaved.new if self.id.nil?
        api.destroy(self.id)
      end

      def api
        raise NotImplementedError.new
      end

      def to_params
        raise NotImplementedError.new
      end

      class << self
        def has_attributes(attributes)
          attributes.each_pair do |name, options|
            attr_reader name
            define_method "#{name}=" do |value|
              if options[:readonly] && !instance_variable_get("@#{name}").nil?
                raise ReadOnlyAttribute.new(name)
              end
              write_attribute(name, self.class.convert_attribute(value, options[:type]))
            end
          end
        end

        def convert_attribute(value, type)
          case type
          when :date
            (value.is_a?(Time) || value.is_a?(DateTime)) ? value.to_date : Date.parse(value)
          when :time
            (value.is_a?(Date) || value.is_a?(DateTime)) ? value.to_time : Time.parse(value)
          when :datetime
            (value.is_a?(Date) || value.is_a?(Time)) ? value.to_datetime : DateTime.parse(value)
          when :integer
            value.to_i
          when :string
            value.to_s
          else
            value
          end
        end
      end

    end
  end
end
