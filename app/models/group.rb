class Group < ApplicationRecord
	has_many :event_groupships, :dependent => :destroy
	has_many :events, :through => :event_groupships, :dependent => :destroy
end
