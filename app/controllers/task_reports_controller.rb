class TaskReportsController < ApplicationController

  def index
    @tasks = current_user.tasks.where(status: 'complete')
  end
end
