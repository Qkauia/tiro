class User < ApplicationRecord

    validates :password, confirmation: true, length: { in: 8..12 }
    validates :email, presence: true, 
                      uniqueness: true, 
                      format: { 
                        with: URI::MailTo::EMAIL_REGEXP ,
                        message: '格式錯誤'
                      }
    before_create :encrypt_password
    
    def encrypt_password
        pw = "x#{self.password}y"
        self.password = Digest::SHA1.hexdigest(pw)
    end
end
