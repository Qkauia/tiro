class OrdersController < ApplicationController
    include Solutionable
    require 'securerandom'
    
    before_action :authenticate_user!

    def pay
        @order = Order.find_by!(num: params[:id])
        @token = gateway.client_token.generate
    end

    def please_pay
        order = Order.find_by!(num: params[:id])

        if order.may_pay?
            result = gateway.transaction.sale(
                amount: order.amount,
                payment_method_nonce: params[:nonce]
            )
            if result.success?
                order.pay!
                redirect_to root_path, notice: "交易成功"
            else
                
                redirect_to root_path, notice: "交易發生錯誤，請稍後再試"
            end
        else
            redirect_to root_path, notice: "此訂單無法付款"
        end
        
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

    def gateway
        gateway = Braintree::Gateway.new(
            environment:  :sandbox,
            merchant_id: Rails.application.credentials.braintree.merchant_id,
            public_key: Rails.application.credentials.braintree.public_key,
            private_key: Rails.application.credentials.braintree.private_key,
        )
    end
end




