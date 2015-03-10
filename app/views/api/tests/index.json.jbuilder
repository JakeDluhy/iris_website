json.array! @tests do |test|
  json.id             test.id
  json.name           test.name
  json.subteam_name   test.team.nil? ? 'undefined' : test.team.name
  json.subteam_id     test.team.nil? ? 'undefined' : test.team.id
  json.test_date      test.test_date.nil? ? "undefined" : test.test_date.strftime("%m/%d/%Y")
  json.test_index     test.test_index
  json.robot_version  test.robot_version
  json.completed_obj  test.test_objectives.where(:status => 'completed').count
  json.incomplete_obj test.test_objectives.where(:status => 'incomplete').count
end