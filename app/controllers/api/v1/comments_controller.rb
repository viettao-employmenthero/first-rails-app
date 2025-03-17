module Api
  module V1
    # app/controllers/api/v1/comments_controller.rb
    class CommentsController < ApplicationController
      before_action :authenticate_user

      def create
        valid_comment = comment_param
        comment = Comments::CommentsService.new(@current_user, valid_comment).call
        render json: comment
      end

      def show
        comment = Comment.find(params[:id])
        render json: comment
      end

      private

      def comment_param
        post = Post.find(params[:comment][:post_id])
        raise 'Invalid comment: user\'s post not correspond with current_user' unless @current_user.id == post.user_id

        if params[:comment][:parent_id]
          parent = Comment.find(params[:comment][:parent_id])
          unless parent.post_id == post.id && parent
            raise 'Invalid comment: parent comment not correspond with post or parent not exist'
          end
        end

        params.require(:comment).permit(:content, :post_id, :parent_id)
      end
    end
  end
end
