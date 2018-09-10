class Api::V1::PaymentsController < ApplicationController
  before_action :set_payment, only: [:received, :paid]

  def received
    @payment.update(received: !@payment.received)

    render json: @payment.expense.user, serializer: UserInfoSerializer
  end

  def paid
    if !@payment.received
      @payment.update(paid: !@payment.paid)
    end
    render json: @payment.user, serializer: UserInfoSerializer
  end

  private
  def set_payment
    @payment = Payment.find(params[:id])
  end
end
