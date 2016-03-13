class Product < ActiveRecord::Base

	 validates :idProduct, presence: true,
                    length: { minimum: 5 }
end
