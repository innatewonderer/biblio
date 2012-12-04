class Book < ActiveRecord::Base
  attr_accessible :title, :author, :description, :date, :image

  has_many :genres
  belongs_to :author

end
