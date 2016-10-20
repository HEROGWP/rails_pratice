require 'rails_helper'

RSpec.describe User, type: :model do
  describe "User admin" do
  	let!(:user) { User.create(email: "test@gmail.com", password: "12345678", password_confirmation: "12345678", role: "admin") }
  
  	it "#admin?" do
  		expect(user).to be_admin
  	end
  end

  describe "User short_name" do
  	let!(:user) { User.create(email: "test@gmail.com", password: "12345678", password_confirmation: "12345678", role: "admin") }
  
  	it "#short_name" do
  		expect(user.short_name).to eq("test")
  	end
  end
end