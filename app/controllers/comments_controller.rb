class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_outfit

  def create
    @comment = @outfit.comments.new(comment_params.merge(user: current_user))

    if @comment.save
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            helpers.dom_id(@outfit, :new_comment),
            partial: "comments/form",
            locals: { outfit: @outfit, comment: Comment.new }
          )
        }
        format.html { redirect_to @outfit }
      end
    else
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            helpers.dom_id(@outfit, :new_comment),
            partial: "comments/form",
            locals: { outfit: @outfit, comment: @comment }
          ), status: :unprocessable_content
        }
        format.html { redirect_to @outfit, alert: @comment.Errors.full_messages.to_sentence }
      end
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.turbo_stream { head :ok }
      format.html { redirect_to @outfit }
    end
  end

private

  def set_outfit
    @outfit = Outfit.find(params[:outfit_id])
  end

  def comment_params
    params.expect(comment: [ :body ])
  end
end
