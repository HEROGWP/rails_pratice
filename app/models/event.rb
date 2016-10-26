class Event < ApplicationRecord
	validates_presence_of :name
	has_many :attendees, :dependent => :destroy
	has_many :event_groupships, :dependent => :destroy
	has_many :groups, :through => :event_groupships, :dependent => :destroy
	has_one :location, :dependent => :destroy
	belongs_to :category
	belongs_to :user
	delegate :name, :to => :category, :prefix => true, :allow_nil => true


	has_attached_file :logo, styles: { medium: "400x400>", thumb: "100x100>" }, default_url: "http://img.chinatimes.com/newsphoto/2016-05-04/656/20160504005468.jpg"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/
end
