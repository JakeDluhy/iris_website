json.array! @users do |user|
  json.id             user.id
  json.name           user.name
  json.email          user.email
  json.bio            user.bio
  json.url            '' #if !user.avatar.nil? ? user.avatar.url : ''
  json.thumb_url      '' #if !user.avatar.nil? ? user.avatar.thumb.url : ''
  json.signed_in      signed_in?
end