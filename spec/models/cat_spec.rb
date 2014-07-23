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

require 'rails_helper'

describe Cat do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:bio) }
    it { is_expected.to validate_presence_of(:breed) }
    it { is_expected.to validate_presence_of(:catchphrase) }
end
