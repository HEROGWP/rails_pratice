class Event < ApplicationRecord
	validates_presence_of :name
	has_many :attendees, :dependent => :destroy
	has_many :event_groupships, :dependent => :destroy
	has_many :groups, :through => :event_groupships, :dependent => :destroy
	has_one :location, :dependent => :destroy
	belongs_to :category
end
