class ApplicationDecorator < Draper::Base
  def format_date(d)
    Chronic.parse(d).strftime("%m/%d/%Y") rescue d
  end
end
