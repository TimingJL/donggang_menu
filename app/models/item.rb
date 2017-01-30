class Item < ApplicationRecord
	belongs_to :restaurant
	validates_presence_of :name, :imageURL, :price # Can't empty.
end
