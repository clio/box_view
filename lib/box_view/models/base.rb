module BoxView
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

    class << self
      def has_attributes(attributes)
        attributes.each_pair do |name, options|
          attr_reader name
          define_method "#{name}=" do |value|
            if options[:readonly] && !instance_variable_get("@#{name}").nil?
              raise "Attempting to set readonly attribute #{name}"
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