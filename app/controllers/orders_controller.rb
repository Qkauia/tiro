class OrdersController < ApplicationController

    require 'securerandom'

    include Solutionable
    
    before_action :authenticate_user!

    def pay
        @order = Order.find_by!(num: params[:id])
    end

    def create
        price = solution_price(order_params[:solution])
        redirect_to root_path, notice: "無此方案" and return if price.nil?

        @order = current_user.orders.new(order_params)
        @order.amount = price

        if @order.save
            redirect_to pay_order_path(@order.num), notice: "即將進入付款頁面"
        else
            render 
        end
    end

    


    private

    def order_params
        params.require(:order).permit(:name, :tel, :solution)
    end

end
