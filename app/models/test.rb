class Test < ActiveRecord::Base

  belongs_to :subteam
  belongs_to :team
  has_many :test_objectives
  has_many :users, :through => :test_objectives
  has_many :pictures, :class_name => "PictureAttachment", :as => :imageable, dependent: :destroy

  after_create :assign_test_index

  def assign_test_index
  	indices = Test.where("ID != ?", self.id).pluck(:test_index)
  	if indices[0].nil?
  		self.test_index = 1
  	else
  		self.test_index = indices.max + 1
  	end
  	self.save!
  end

end