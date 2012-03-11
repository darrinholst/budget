class BudgetDecorator < ApplicationDecorator
  decorates :budget

  def starts_on
    format_date(budget.starts_on)
  end

  def starts_on_before_type_cast
    format_date(budget.starts_on_before_type_cast)
  end
end
