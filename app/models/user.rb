class User < ApplicationRecord
    # callback
    before_create :encrypt_password

    # relationships
    has_many :articles
    has_many :comments
    has_many :albums
    has_many :orders

    has_many :like_logs
    has_many :liked_articles, through: :like_logs, source: :article

    # vaidations
    validates :password, confirmation: true, length: { in: 8..12 }
    validates :email, presence: true, 
                      uniqueness: true, 
                      format: { 
                        with: URI::MailTo::EMAIL_REGEXP ,
                        message: '格式錯誤'
                      }
    
    def display_name
      name.presence || email.split("@").first.capitalize
        # if self.name.present?
        #     self.name
        # else
        #     self.email.split("@").first.capitalize
        # end
    end
    #instance methods
    def toggle_like(record)
      if liked?(record)
        unlike!(record)
        return false
      else 
        like!(record)
        return true
      end
    end

    def liked?(record)
      liked_articles.include?(record)
    end

    
    # class methods
    def self.login(email, password)
      return nil if email.empty? or password.empty?

      password = Digest::SHA1.hexdigest("x#{password}y".reverse)

      find_by email: email, password: password
    end

    def self.logout
      session[:xman].remove
    end

    private

    def encrypt_password
        pw = "x#{self.password}y".reverse
        self.password = Digest::SHA1.hexdigest(pw)
    end

    def like!(record)
      liked_articles << record
    end

    def unlike!(record)
      liked_articles.destroy(record)
    end
end
