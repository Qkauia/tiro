require 'rails_helper'

RSpec.feature "Users", type: :feature do
  it "可以註冊" do
    visit "/"
    click_on "註冊"

    expect(page).to have_content("註冊帳號")

    fill_in 'Name',with: 'kkkkkkk'
    fill_in 'E-mail',with: '8@8.jj'
    fill_in 'Password',with: '123445678'
    fill_in 'Password confirmation',with: '123445678'

    click_on "送出"
    
    expect(page).to have_content('註冊成功:)')
    expect(current_path).to eq '/'

  end

  it "可以登入" do
    #建立會員
    User.create(email: 'cc@cc.cc', password: '12341234')

    visit "/"

    click_on '登入'
    expect(page).to have_content '會員登入'

    fill_in 'E-mail',with: 'cc@cc.cc'
    fill_in 'Password',with: '12341234'

    click_on "送出"

    expect(page).to have_content('登入成功！！')
    expect(current_path).to eq '/'
  end

  # it "" do
  #   visit "/"

end
