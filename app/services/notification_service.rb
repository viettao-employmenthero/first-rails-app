class NotificationService
  def initialize(user, message)
    @user = user
    @message = message
  end

  def send
    # Simulating a notification (you can replace this with actual logic)
    puts "Sending notification to #{@user.email}: #{@message}"
  end
end