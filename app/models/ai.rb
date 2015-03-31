class Ai < ActiveRecord::Base
	has_many :bots_probabilities, :dependent => :destroy
	has_many :ticket_probabilities, :dependent => :destroy
	accepts_nested_attributes_for :bots_probabilities, reject_if: proc { |attributes| attributes['probability'].blank? }
 	accepts_nested_attributes_for :ticket_probabilities, reject_if: proc { |attributes| attributes['probability'].blank? }
  attr_accessor :redirect_path
end
