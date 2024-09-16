# app/reflexes/task_reflex.rb
class TaskReflex < ApplicationReflex
  
  def assigned_task(data)
    @record = JSON.parse(data["data"])
    Task.find(@record["task_id"]).update(assigned: true)
    @tasks = Task.all
    morph "#updateTaskForm tbody", render(partial: "tasks/table_body", locals: { tasks: @tasks })
  end
  
end
