# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  image_uid   :string(255)
#  bio         :text
#  birthdate   :date
#  breed       :string(255)
#  catchphrase :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Cat < ActiveRecord::Base
  dragonfly_accessor :image
  validates :name, :bio, :breed, :catchphrase, presence: true
end
