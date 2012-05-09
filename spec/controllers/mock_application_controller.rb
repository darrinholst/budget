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
  end
end

