class Ability
	
	include CanCan::Ability

	def initialize(user)
		if user.present?
			if user.is? "admin"
				can :manage, :all
			end
		end
	end

end