# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  subtitle   :string
#  user_id    :integer
#  deleted_at :datetime
#  password   :string
#
class Article < ApplicationRecord
    #假刪除套件
    acts_as_paranoid

    validates :title, presence: true

    enum category: { kids: 0, adult: 1, oldman: 2, others: 3}
    
    
    belongs_to :user
    has_many :comments, -> { order(id: :desc) }

    has_many :like_logs
    has_many :users, through: :like_logs

    def self.ransackable_attributes(auth_object = nil)
        [ "content", "subtitle", "title", "user_id"]
    end

    def self.ransackable_associations(auth_object = nil)
        # ["comments", "like_logs", "user", "users"]
        []
    end

    
    # def self.search(keyword)
    #     if keyword.present?
    #         where("title LIKE '%#{keyword}%' OR content LIKE '%#{keyword}%'").order(id: :desc) 
    #     else
    #         all
    #     end
    # end

    

end

    #手製假刪除
    # default_scope { where(deleted_at: nil) }
    # def destroy
    #     update(deleted_at: Time.current)
    # end
