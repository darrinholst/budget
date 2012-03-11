class BudgetDecorator < ApplicationDecorator
  decorates :budget

  def starts_on
    format_date(budget.starts_on)
  end

  def starts_on_before_type_cast
    format_date(budget.starts_on_before_type_cast)
  end

  def budgeted_income
    format_money(budget.budgeted_income)
  end

  def budgeted_expenses
    format_money(budget.budgeted_expenses)
  end

  def budgeted_buffer
    format_money(budget.budgeted_buffer)
  end

  def actual_balance
    format_money(budget.actual_balance)
  end

  def left_to_spend
    format_money(budget.left_to_spend)
  end

  def actual_buffer
    format_money(budget.actual_buffer)
  end

  private

  def format_money(money)
    money.format.gsub(/\$/, "")
  end
end
