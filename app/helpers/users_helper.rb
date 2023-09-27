module UsersHelper
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
end
