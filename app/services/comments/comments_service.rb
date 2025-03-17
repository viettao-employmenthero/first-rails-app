module Comments
  # app/services/comments/comments_service.rb
  class CommentsService
    def initialize(user, comment_params)
      @user = user
      @comment_params = comment_params
    end

    def call
      comment = @user.comments.new(@comment_params)

      raise ActiveRecord::RecordInvalid, comment unless comment.save

      comment
    end
  end
end
