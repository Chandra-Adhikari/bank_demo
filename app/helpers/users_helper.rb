module UsersHelper
	def user_name
		current_user.try(:name)
	end

	def email
		current_user.try(:email)
	end

	def address
		current_user.try(:address)
	end

	def image
		current_user.try(:image_url)
	end
end
