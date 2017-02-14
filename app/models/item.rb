class Item < ApplicationRecord
	belongs_to :restaurant
	validates_presence_of :name, :price # Can't empty. , :imageURL
end
