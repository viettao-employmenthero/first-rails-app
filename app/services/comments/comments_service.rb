module Comments
  class CommentsService
    def initialize(user, comment_params)
      @user = user
      @comment_params = comment_params
    end

    def call
      valid_comment = validate_comment_params
      comment = @user.comments.new(valid_comment)

      if comment.save
        ServiceResponse.new(comment)
      else
        ServiceResponse.new(nil, comment.errors)
      end
    end

    private

    def validate_comment_params
      post = Post.find(@comment_params[:post_id])
      raise 'Invalid comment: user\'s post not correspond with current_user' unless @user.id == post.user_id

      if @comment_params[:parent_id]
        parent = Comment.find(@comment_params[:parent_id])
        unless parent.post_id == post.id && parent
          raise 'Invalid comment: parent comment not correspond with post or parent not exist'
        end
      end

      @comment_params.permit(:content, :post_id, :parent_id)
    end
  end
end
