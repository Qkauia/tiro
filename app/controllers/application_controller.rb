class ApplicationController < ActionController::Base
    #意外處理
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    #helper匯出給view使用
    helper_method :user_signed_in?, :current_user
    private

    def authenticate_user!
        if not user_signed_in?
            redirect_to login_users_path, notice: "請先登入會員"
        end
    end

    def user_signed_in?
        session[:xman].present?
    end

    def current_user
        if user_signed_in?
            #記憶
            @__user__ ||= User.find_by(id: session[:xman])
        else
            nil
        end
    end

    def not_found
        render file: Rails.root.join('public', '404.html'),
                            status: 404, 
                            layout: false 
                            #路徑#狀態404,#移除layout(移除另一個外殼)
    end
end
