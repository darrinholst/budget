require 'active_model'

module ActiveRecord
  class Base
    include ActiveModel::Validations

    class << self
      def where(args)
        self
      end

      def order(args)
        self
      end

      def method_missing(meth, *args)
      end
    end

    def method_missing(meth, *args)
      if meth =~ /.*=$/
        attributes[meth[0...-1].to_sym] = args.first
      else
        attributes[meth]
      end
    end

    def write_attribute(name, value)
      attributes[name] = value
    end

    private

    def attributes
      @attributes ||= {}
    end
  end
end

