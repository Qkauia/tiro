require 'rails_helper'

RSpec.feature "Users", type: :feature do
  let(:user) { create(:user)}
  it "可以註冊" do
    sing_up(name: '晶心老爹',
          email: '888@888.888',
          password: '12345678', 
          password_confirm: '12345678' )
    
    expect(page).to have_content('註冊成功:)')
    expect(current_path).to eq '/'

  end

  it "可以登入" do
    #建立會員
    
    
    login(email: user.email, password: '12345678')

    expect(page).to have_content('登入成功！！')
    expect(current_path).to eq '/'
  end

  it "不可重複註冊" do
    
    
    
    sing_up(name: 'Qoo',
            email: user.email,
            password: '12345678', 
            password_confirm: '12345678' )
    
    expect(page.status_code).to be 422
    #E-mail輸入框出現紅框
    #頁面表留在
  end


  

end


# expect(page).to have_css('.field_with_errors', count: 3)