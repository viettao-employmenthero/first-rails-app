module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authenticate_user

      def create
        comment = Comments::CommentsService.new(@current_user, params[:comment]).call
        unless comment.success?
          return render json: GoogleJsonResponse.render_error(comment.errors, code: 'INVALID').to_json
        end

        render json: comment
      end

      def show
        comment = Comment.find(params[:id])
        authorize comment
        render json: comment
      end

      def destroy
        comment = Comment.find(params[:id])
        authorize comment
        comment.destroy
        head :no_content
      end
    end
  end
end
