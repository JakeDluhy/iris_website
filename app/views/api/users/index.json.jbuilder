json.array! @users do |user|
  json.id             user.id
  json.name           user.name
  json.email          user.email
  json.bio            user.bio
  json.url            user.avatar.url
  json.thumb_url      user.avatar.thumb.url
  json.signed_in      signed_in?
end