class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # has_many :table_config_users
  # has_many :table_configs, through: :table_config_users
  # has_many :table_users
  # has_many :tables, through: :table_users

end
