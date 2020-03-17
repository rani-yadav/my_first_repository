
class QuestionsController < ApplicationController
	before_action :set_question, only:[:edit, :update, :destroy]
	
	def index
		@questions = Question.all
	end 

	def new
		@question = current_user.questions.build
	end 

	def show
		@question = Question.find_by(id: params[:id])
		if @question
	  	@question.user = current_user
			@answers = @question.answers
			@comments = @question.comments
		else 
		 @answer = Answer.find_by(id: params[:id])
		 @question = @answer.question
		 @answer.user = current_user
		 @comments = @answer.comments
		 @answers = @question.answers
		end 
	end 

	def create
		@question= current_user.questions.build(question_params)
		if @question.save
			redirect_to user_questions_path(current_user), notice:"question was successfuly created"
		else
			render :new 
		end 
	end 

	def edit
	end 

	def update
		if @question.update(question_params)
			redirect_to user_questions_path(current_user, @question)
		else
			render :edit
		end
	end 

	def destroy
		if @question.destroy
			redirect_to user_questions_path(current_user), notice:"question was successfuly destroyed"
		else  
			render :new 
		end 
	end 

	private

	def set_question 
		@question = current_user.questions.find_by(id: params[:id])
	end 

	def question_params
		params.require(:question).permit(:title, :body, category:[])
	end
end