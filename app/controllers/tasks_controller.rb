class TasksController < ApplicationController
  # before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all
  end

  def find_user_email
    @user_email = User.find(params[:id]).email
    render json: [{ email: @user_email }], status: :ok
  end

  # # GET /tasks/1 or /tasks/1.json
  # def show
  # end

  # # GET /tasks/new
  # def new
  #   @task = Task.new
  # end

  # # GET /tasks/1/edit
  # def edit
  # end

  def create
    @task = Task.new(task_params)
  
    if @task.save
      render json: @task, status: :created
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def testing_purpose
  end
  # # PATCH/PUT /tasks/1 or /tasks/1.json
  # def update
  #   respond_to do |format|
  #     if @task.update(task_params)
  #       format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
  #       format.json { render :show, status: :ok, location: @task }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @task.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /tasks/1 or /tasks/1.json
  # def destroy
  #   @task.destroy!

  #   respond_to do |format|
  #     format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_task
  #     @task = Task.find(params[:id])
  #   end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :task, :description, :user_id)
    end
end
