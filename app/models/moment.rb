class Moment < ApplicationRecord
  belongs_to :user, optional: true

  after_create :process_message

  def process_message
    @user = User.find_by_phone(phone)
    if @user
    	self.update(user: @user)
    end
  end
end
