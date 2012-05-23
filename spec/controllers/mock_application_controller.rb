class ApplicationController
  class << self
    def method_missing(meth, *args)
    end
  end

  def params=(params)
    @params = params
  end

  def params
    @params ||= {}
  end

  def method_missing(meth, *args)
    if meth =~ /.*=$/
      attributes[meth[0...-1].to_sym] = args.first
    else
      attributes[meth]
    end
  end

  private

  def attributes
    @attributes ||= {}
  end
end

