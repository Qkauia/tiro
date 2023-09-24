class ApplicationController < ActionController::Base
    #意外處理
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    private

    def not_found
        render file: Rails.root.join('public', '404.html'),
                            status: 404, 
                            layout: false 
                            #路徑#狀態404,#移除layout(移除另一個外殼)
    end
end
