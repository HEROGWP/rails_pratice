 require 'rails_helper'

 describe "Hello" do 
 	it "hi" do 
 		x = 1+1
 		expect( x ).to eq(2)

 		User.create(email: "test@gmail.com", password: "12345678", password_confirmation: "12345678", role: "admin")
    user = User.new(email: "test@gmail.com", password: "12345678", password_confirmation: "12345678", role: "admin")
    expect(user.save).to eq(false)

    #比大小，我只要大於一就好
    expect(1 + 1).to be > 1

    #只要不要等於3就好
    expect(1 + 1).not_to eq(3)

 	end

 	it "array" do
 		a = []
 		expect(a).to be_empty

 		expect(a.empty?).to eq(true)
 	end 	

 	it "is Array" do
 		a=[1,2,3]
 		expect(a.is_a?(Array)).to eq(true)

 		expect(a).to be_is_a(Array)
 	end

 	it "change" do
 		user = User.create(email: "test@gmail.com", password: "12345678", password_confirmation: "12345678", role: "admin")
 		expect{
 			user.update(role: "user")
 		}.to change{user.reload.role}

 		#也可以寫成
 		user = User.create(email: "pp820819@gmail.com", password: "12345678", password_confirmation: "12345678", role: "admin")
 		# byebug
 		ori_name = user.reload.role
 		user.update(role: "user")
 		expect(ori_name).not_to eq(user.reload.role)
 	end
 end