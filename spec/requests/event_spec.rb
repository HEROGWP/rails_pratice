require 'rails_helper'

RSpec.describe EventsController, type: :request do
  before { host! "localhost:3000" }
  describe '#index' do
    it 'success' do
      get '/events'
      expect(response.status).to eq(200)
    end
  end

  describe '#create' do
  	let!(:user) { create :user }
    let!(:catgory){ Category.create(name: "ruby") }
    let(:user_params){{user: {email: "test@gmail.com", password: "12345678"}}}

    it 'success' do
    	post '/users/sign_in', params: user_params
    	expect(response.status).to eq(302)
    	expect(response).to be_redirect

    	post '/events', params: { event: { name: "hihi", category_id: 1} }

    	expect(response.status).to eq(302)
    	expect(response).to redirect_to("/events")
    end

    it 'fail' do
    	post '/users/sign_in', params: user_params
    	expect(response.status).to eq(302)
    	expect(response).to be_redirect

    	post '/events', params: { event: { name: "hihi"} }

    	expect(response.status).to eq(200)
    	expect(response).to render_template('events/new')
    end
  end

  describe '#update' do
  	
  end
end