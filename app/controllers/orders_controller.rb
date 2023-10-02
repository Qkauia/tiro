class OrdersController < ApplicationController

    require 'securerandom'

    include Solutionable
    
    before_action :authenticate_user!

    def pay
        @order = Order.find_by!(num: params[:id])

        gateway = Braintree::Gateway.new(
            environment:  :sandbox,
            merchant_id:  '9s6qxh93s5h6xmjt',
            public_key:  '879mrhdqz84hh759',
            private_key:  '153047bba84c7319cb447e1d9a438288',
        )

        @token = gateway.client_token.generate
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
