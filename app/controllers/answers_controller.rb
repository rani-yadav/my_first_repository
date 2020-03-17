class AnswersController < ApplicationController
	
	def index
		@question = Question.find(params[:question_id])
		@answers = Answer.all
	end 

	def new
		@question = Question.find(params[:question_id])
		@answer = @question.answers.build 
	end 

	def show
		@question = Question.find(params[:question_id])
		@answer= Answer.find_by(id: params[:id])
	end

	def create
		@question = Question.find_by(id: params[:question_id])
		@answer= @question.answers.build(answer_params)
		@answer.user = current_user
		respond_to do |format|
		if @answer.save
			format.js 
			format.html {redirect_to user_question_path(current_user, @question), notice: "answer was successfully created"}
		else
			render :new
			end
		end
	end 

	def edit
	 	@question = Question.find_by(id: params[:question_id])
	 	@answer= Answer.find_by(id: params[:id])
	end 

	def update
	 @question = Question.find_by(id: params[:question_id])
	 @answer= Answer.find_by(id: params[:id])
		if@answer.update(answer_params)
		 	redirect_to user_question_path(current_user, @question), notice: "answer was successfully updated"
		else 
		 render :edit
		end
	end
	 	

	def destroy
		@question = Question.find_by(id: params[:question_id])
		@answer= Answer.find_by(id: params[:id])
		@answer.destroy
		redirect_to user_question_path(current_user, @question), notice: "answer was successfully destroyed"
	end 

	def answer_params
		params.require(:answer).permit(:body, :question_id)
	end 
end
