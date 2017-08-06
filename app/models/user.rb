class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :moments

  EIGHT_HOURS = 28800
  TWENTY_HOURS = 72000

  validates :email, uniqueness: true
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  def send_welcome_text
    if self.phone
			@client = Twilio::REST::Client.new
      @sent_message = @client.messages.create(
		      from: Rails.application.secrets.twilio_from,
		      to: self.phone, # assumes that number is from US
		      body: "Welcome to gratitude moment! You will now receive daily reminders to take a moment for gratitude, which you can then reply with something your grateful for."
		    )
    end
  end

  def time_zone_preference
    @time_zone_modifier = Time.zone.now.in_time_zone(self.time_zone).utc_offset.abs.seconds
    return @time_zone_modifier
  end

  def schedule_texts
    if self.active?
      morning = Date.tomorrow.beginning_of_day + EIGHT_HOURS + time_zone_preference
      night = Date.tomorrow.beginning_of_day + TWENTY_HOURS + time_zone_preference
      self.delay(run_at: morning).send_text
      self.delay(run_at: night).send_text
    end
  end

  def send_text
		@client = Twilio::REST::Client.new
    @sent_message = @client.messages.create(
	      from: Rails.application.secrets.twilio_from,
	      to: self.phone, # assumes that number is from US
	      body: "What are you grateful for?"
	    )
  end
end
