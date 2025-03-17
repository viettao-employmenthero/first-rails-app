# app/policies/comment_policy.rb
class CommentPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def create?
    user.present? && user.id == comment.post.user_id
  end

  def show?
    user.present? && user.id == comment.post.user_id
  end

  def update?
    user.present? && user.id == comment.user_id
  end

  def destroy?
    user.present? && user.id == comment.user_id
  end
end
