class Restaurant < ApplicationRecord
	has_many :items
	geocoded_by :address        #從address欄位取出地址
	after_validation :geocode   #將取出的地址自動轉為經緯度分別存在 latitude、longitude 欄位
	validates_presence_of :name, :imageURL # Can't empty.
	has_attached_file :image, styles: { medium: "700x500#", small: "350x250>" }
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/ 
end