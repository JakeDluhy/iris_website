json.array! @updates do |update|
  json.id             update.id
  json.title          update.title
  json.content        markdown(update.content)
  json.author_name    update.author.name
  json.author_id      update.author.id
  json.team_name      update.team.nil? ? '' : update.team.name
  json.team_id        update.team.nil? ? 1 : update.team.id
  json.subteam_name   update.subteam.nil? ? '' : update.subteam.name
  json.subteam_id     update.subteam.nil? ? 1 : update.subteam.id
  json.pictures       update.pictures
  json.created_at     update.created_at.strftime('%m/%d/%y')
  json.logged_in_id   current_user.id
end