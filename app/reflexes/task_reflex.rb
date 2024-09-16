# app/reflexes/task_reflex.rb
class TaskReflex < ApplicationReflex
  before_reflex do
    Rails.logger.info "Before Reflex: Preparing task"
    @task = GlobalID::Locator.locate_signed(element.dataset.signed_id)
    @task.assign_attributes(task_params)
  end
  def create
    binding.pry
    if @task.save
      cable_ready["task-list"].insert_adjacent_html(
        position: "beforeend",
        html: ApplicationController.render(partial: "tasks/task", locals: { task: @task })
      )
      morph "#new-task-form", "" # Optionally clear the form fields after submission
      cable_ready.broadcast
    else
      # Handle validation errors, e.g. rendering form errors in real-time
    end
  end

  private

  def task_params
    {
      title: element[:title], 
      description: element[:description],
      user_id : element[:user_id]
    }
  end
end
