json.array! @tasks do |task|
  json.id             task.id
  json.title          task.title
  json.content        task.content
  json.author_name    task.author.name
  json.author_id      task.author.id
  json.team_name      task.team.nil? ? '' : task.team.name
  json.team_id        task.team.nil? ? 1 : task.team.id
  json.subteam_name   task.subteam.nil? ? '' : task.subteam.name
  json.subteam_id     task.subteam.nil? ? 1 : task.subteam.id
  json.pictures       task.pictures
  json.users          task.users
end