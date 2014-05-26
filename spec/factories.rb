FactoryGirl.define  do
	factory :user do
		name	"Jake Dluhy"
		email	"jake@example.com"
		password "foobar"
		password_confirmation "foobar"
	end
end