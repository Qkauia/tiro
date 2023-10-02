require 'securerandom'
class OrdersController < ApplicationController
    before_action :authenticate_user!

    def create
        price = solution_price(order_params[:solution])
        redirect_to root_path, notice: "無此方案" and return if price.nil?

        @order = current_user.orders.new(order_params)
        @order.amount = price

        if @order.save
            redirect_to root_path, notice: "進入付款頁面"
        else
            render 
        end
    end


    private

    def order_params
        params.require(:order).permit(:name, :tel, :solution)
    end

    def solution_price(s)
        solutions = {pro: 10, premium: 50}
        solutions[s.to_sym]
    end
end
