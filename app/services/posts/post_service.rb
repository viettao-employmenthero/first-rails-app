module Posts
  # app/services/posts/post_service.rb
  class PostService
    def initialize(user, post_params)
      @user = user
      @post_params = post_params
    end

    def call
      post = @user.posts.new(@post_params)

      if post.save
        send_notification(post)
        post
      else
        raise ActiveRecord::RecordInvalid, post
      end
    end

    private

    def send_notification(post)
      # Imagine we have a NotificationService to handle notifications
      NotificationService.new(post.user, "Your post '#{post.title}' was created!").send
    end
  end
end
