class Category < ApplicationRecord
	has_many :categorizations
	has_many :restaurants, through: :categorizations
end
