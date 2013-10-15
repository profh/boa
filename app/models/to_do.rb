class ToDo < ActiveRecord::Base
	attr_accessible :title, :notes, :created_by, :completed_by, :due_date, :assigned_person, :todo_category

	# Relationships
	has_many :todo_categories

	# Validations
	validates :title, :notes, :created_by, :completed_by, :due_date, :assigned_person, :presence => true
	validates :due_date, :date => { :after => :created_at }

	# Scopes
	default_scope order('due_date DESC')
	
  
end
