class Room < ActiveRecord::Base
  serialize :contents
  belongs_to :user
end
