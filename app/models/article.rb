class Article < ApplicationRecord
    #假刪除套件
    acts_as_paranoid

    validates :title, presence: true
    
    belongs_to :user
    has_many :comments

    
end

    #手製假刪除
    # default_scope { where(deleted_at: nil) }
    # def destroy
    #     update(deleted_at: Time.current)
    # end
