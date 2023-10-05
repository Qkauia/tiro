module UserHelper

    #登入
    def login(email:, password:)
        visit "/"
    
        click_on '登入'
        expect(page).to have_content '會員登入'
    
        fill_in 'E-mail',with: email
        fill_in 'Password',with: password
        click_on "送出"
    end
    
    
    #註冊
    def sing_up(name:, email:, password:, password_confirm:)
        visit "/"
        click_on "註冊"
    
        expect(page).to have_content("註冊帳號")
    
        fill_in 'Name',with: name
        fill_in 'E-mail',with: email
        fill_in 'Password',with: password
        fill_in 'Password confirmation',with: password_confirm
        click_on "送出"
    end

end