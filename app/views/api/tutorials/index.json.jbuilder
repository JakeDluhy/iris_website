json.array! @tutorials do |tutorial|
  json.id             tutorial.id
  json.title          tutorial.title
  json.author_name    tutorial.author.name
  json.author_id      tutorial.author.id
  json.team_name      tutorial.team.nil? ? '' : tutorial.team.name
  json.team_id        tutorial.team.nil? ? 1 : tutorial.team.id
  json.subteam_name   tutorial.subteam.nil? ? '' : tutorial.subteam.name
  json.subteam_id     tutorial.subteam.nil? ? 1 : tutorial.subteam.id
  json.instructions   tutorial.instructions do |instruction|
    json.title        instruction.title
    json.content      markdown(instruction.content)
    json.order_id     instruction.order_id
    json.pictures     instruction.pictures
  end
  json.created_at     tutorial.created_at.strftime('%m/%d/%y')
  json.logged_in_id   current_user.id
end