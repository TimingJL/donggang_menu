module RestaurantsHelper
	#https://makandracards.com/makandra/29353-tel_to-rails-helper-for-linking-phone-numbers
	def tel_to(text)
	  groups = text.to_s.scan(/(?:^\+)?\d+/)
	  link_to text, "tel:#{groups.join '-'}"
	end	
end
