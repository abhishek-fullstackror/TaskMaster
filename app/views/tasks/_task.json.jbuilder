json.extract! task, :id, :title, :task, :description, :user_id, :created_at, :updated_at
json.url task_url(task, format: :json)
