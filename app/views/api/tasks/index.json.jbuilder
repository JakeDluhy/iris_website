json.array! @tasks do |task|
  json.id             task.id
  json.title          task.title
  json.content        markdown(task.content)
  if task.author.nil?
    json.author_name    'Unknown'
    json.author_id      0
  else
    json.author_name    task.author.name
    json.author_id      task.author.id
  end
  json.team_name      task.team.nil? ? '' : task.team.name
  json.team_id        task.team.nil? ? 1 : task.team.id
  json.subteam_name   task.subteam.nil? ? '' : task.subteam.name
  json.subteam_id     task.subteam.nil? ? 1 : task.subteam.id
  json.pictures       task.pictures
  json.users          task.users
  json.created_at     task.created_at.strftime('%m/%d/%y')
  json.logged_in_id   current_user.nil? ? -1 : current_user.id 
end