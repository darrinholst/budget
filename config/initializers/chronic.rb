module Chronic
  class << self
    alias :old_parse :parse

    def parse(value)
      return value if value.nil? || value.is_a?(Time) || value.is_a?(Date)
      old_parse(value.gsub(/\.\d*$/, ""))
    end
  end
end
