class User < ApplicationRecord

    validates :password, confirmation: true, length: { in: 8..12 }
    validates :email, presence: true, 
                      uniqueness: true, 
                      format: { 
                        with: URI::MailTo::EMAIL_REGEXP ,
                        message: '格式錯誤'
                      }
    before_create :encrypt_password
    
    
    def self.login(email, password)
      return nil if email.empty? or password.empty?

      password = Digest::SHA1.hexdigest("x#{password}y".reverse)

      find_by email: email, password: password
    end

    private
    def encrypt_password
        pw = "x#{self.password}y".reverse
        self.password = Digest::SHA1.hexdigest(pw)
    end
end
