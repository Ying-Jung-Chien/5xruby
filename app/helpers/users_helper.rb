module UsersHelper
  def count_tasks(id)
    Task.where("user_id = ?", id).count
  end
end
