# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  num        :string
#  name       :string
#  tel        :string
#  status     :string
#  solution   :string
#  amount     :integer
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Order < ApplicationRecord
  belongs_to :user
  require 'securerandom'
  before_create :set_num

  private

  def set_num
    self.num = num_generator
  end
  
  #2023mmdd-XAB2DE
  def num_generator
	d = Time.now.strftime("%Y%m%d")
	r = SecureRandom.alphanumeric(6).upcase
  "#{d}-#{r}"
  end

end

#  amount     :integer
#pending X
#paid
#cancelled
#failed