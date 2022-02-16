class TasksController < ApplicationController
  before_action :authenticate_user!, only: %i[index new create destroy search]
  before_action :user_profile?
  #before_action :find_task, only: %i[edit update show confirm_delete destroy delete_comment]
  skip_before_action :verify_authenticity_token, only: %i[search]

  def index
    @tasks = current_user.tasks
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
      if @task.save
        redirect_to tasks_path, notice: 'Task created successfully'
      else
        #Se não for possível realizar a ação (salvar) eu mostrarei, por padrão, a msg
        #de erro e renderizo o new. Farei isso em outros métodos.
        flash[:danger] = @task.errors.full_messages
        render :new
      end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
      if @task.update(task_params)
        redirect_to tasks_path, notice: 'Task updated successfully'
      else
        flash[:danger] = @task.errors.full_messages
        render :edit
      end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: 'Task Deleted'
  end

  def complete
  end

  def incomplete
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :priority)
  end

  def comment_params
  end

  def sanitize_sql_like(string, escape_character = "\\")
    pattern = Regexp.union(escape_character, "%", "_")
    string.gsub(pattern) { |x| [escape_character, x].join }
  end
end

