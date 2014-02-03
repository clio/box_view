module BoxView
  class Base

    attr_accessor :session

    def initialize(fields = {}, session = nil)
      self.session = session
      fields.each_pair do |k, v|
        self.send("#{k}=", v) if self.respond_to?("#{k}=") && !v.nil?
      end
    end

  end
end