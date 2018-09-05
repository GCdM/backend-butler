class Api::V1::ExpensesController < ApplicationController

  def create
    @expense = Expense.new(expense_params)

    if @expense.save
      render json: @expense
    else
      render json: { error: "Could not create Expense" }
    end
  end

  private
  def expense_params
    params.require(:expense).permit(:user_id, :title, :description, :date, :amount)
  end
end
