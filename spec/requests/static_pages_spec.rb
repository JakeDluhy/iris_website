require 'spec_helper'

describe "StaticPages" do

  describe "Home page" do

  	it "should have the content 'IRIS'" do
  		visit '/static_pages/home'
  		expect(page).to have_content('IRIS')
  	end

  	it "should have the proper title" do
  		visit '/static_pages/home'
  		expect(page).to have_title('IRIS | Home')
  	end
  end

  describe "About page" do

  	it "should have the content 'Illinois Robotics In Space'" do
  		visit '/static_pages/about'
  		expect(page).to have_content('Illinois Robotics In Space')
  	end

  	it "should have the proper title" do
  		visit '/static_pages/about'
  		expect(page).to have_title('IRIS | About')
  	end
  end
end
