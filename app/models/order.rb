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
  include AASM
  #paid
  #cancelled
  #failed

  aasm column: 'status' , no_direct_assignment: true do
    state :pending, initial: true#預設值
    state :paid, :cancelled, :failed#其他status

    event :pay do
      transitions from: :pending, to: :paid
    end

    event :cancel do
      transitions from: [:pending, :paid ], to: :cancelled
    end

    event :fail do
      transitions from: :pending, to: :failed
    end
  end

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



