class Genre < ActiveRecord::Base
  attr_accessible :name

  belongs_to  :book
  belongs_to  :author
end
