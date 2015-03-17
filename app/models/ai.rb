class Ai < ActiveRecord::Base
	has_many :bots_probabilities
	accepts_nested_attributes_for :bots_probabilities, reject_if: proc { |attributes| attributes['probability'].blank? }
end
