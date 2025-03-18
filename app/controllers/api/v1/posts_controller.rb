# frozen_string_literal: true

module Api
  module V1
    # PostsController
    class PostsController < ApplicationController

      before_action :authenticate_user

      def create
        post = Posts::PostService.new(@current_user, post_params).call
        render json: post, status: :created
      rescue ActiveRecord::RecordInvalid => e
        render json: { error: e.message }, status: :unprocessable_entity
      end

      def show
        post = Post.find(params[:id])
        render json: post
      end

      def destroy
        post = Post.find(params[:id])
        post.destroy
        head :no_content
      end

      private

      def post_params
        params.require(:post).permit(:title, :content, :category_id)
      end
    end
  end
end
