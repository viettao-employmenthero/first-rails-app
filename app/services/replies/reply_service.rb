module Replies
  # app/services/replies/reply_service.rb
  class ReplyService
    def initialize(user, reply_params)
      @user = user
      @reply_params = reply_params
    end
  end
end
