class Recipe < ActiveRecord::Base
  attr_accessible :chicken, :dessert, :meat, :appetizer, :content, :title, :user_id, :vegetarian
end
