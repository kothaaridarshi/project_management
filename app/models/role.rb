class Role < ApplicationRecord
	# Association
	has_many :users, dependent: :destroy
end
