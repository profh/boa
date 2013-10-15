class ToDoCategory < ActiveRecord::Base
	attr_accessible :name

	# Relationships

	# Validations
	validates :name, :presence => true

	# Scopes
  
end
