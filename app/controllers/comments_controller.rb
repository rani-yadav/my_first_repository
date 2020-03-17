
class CommentsController < ApplicationController
	before_action :find_commentable, only:[:index, :new, :create, :edit, :update,  :destroy]
  before_action :set_commentable, only:[:edit, :update, :destroy]
 
	def index
		@comments= Comment.all
	end 

	def new
		@comment = Comment.new 
	end

	def create
		@comment= @commentable.comments.build(comment_params)
		@comment.user = current_user
    @comment.save 
    respond_to do |format|
    if @comment.commentable_type == "Question"
      format.js
      format.html {redirect_to user_question_path(current_user, @commentable), notice: "comment was successfully created"}
    else  
      format.js  
     format.html {redirect_to user_question_path(current_user, @commentable), notice: "comment was successfully created"}
      end
    end 
  end

  def edit
  end 

  def update
    if @comment.update(comment_params)
    	redirect_to user_question_path(current_user, @commentable), notice: "comment was successfully updated"
  	else
  		render :edit
  	end   	
  end 

  def destroy
    @comment.destroy
    redirect_to user_question_path(current_user, @commentable), notice: "comment was successfully destroy"
  end

	private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_commentable
    if params[:answer_id]
      @commentable = Answer.find_by_id(params[:answer_id]) 
    else params[:question_id]
      @commentable = Question.find_by_id(params[:question_id])
    end
  end 

  def set_commentable
    @comment = @commentable.comments.find_by(id: params[:id])
  end 
end

