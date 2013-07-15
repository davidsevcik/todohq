require 'spec_helper'

describe UsersController do
  include Devise::TestHelpers

  describe "POST #create" do
    context "with valid params" do
      it "creates new user and returns auth token" do
        post :create, email: 'joe@doe.com', password: '123456', password_confirmation: '123456', format: :json
        expect(response).to be_success
        expect(User.exists? email: 'joe@doe.com').to be_true
        json = JSON.parse(response.body)
        expect(json['authentication_token']).not_to be_blank
      end
    end

    context "with invalid email" do
      it "does not create user and returns errors" do
        post :create, email: 'foobar', password: '123456', password_confirmation: '123456', format: :json
        expect(response).not_to be_success
        expect(response.status).to eq 422
        expect(User.exists? email: 'foobar').to be_false
        json = JSON.parse(response.body)
        expect(json['errors']).not_to be_blank
      end
    end

    context "without confirmed password" do
      it "does not create user and returns errors" do
        post :create, email: 'joe@doe.com', password: '123456', password_confirmation: '', format: :json
        expect(response).not_to be_success
        expect(response.status).to eq 422
        expect(User.exists? email: 'joe@doe.com').to be_false
        json = JSON.parse(response.body)
        expect(json['errors']).not_to be_blank
      end
    end
  end


  describe "GET #show" do
    let(:user) do
      user = FactoryGirl.build :user
      user.ensure_authentication_token!
      user
    end

    context "with valid auth token" do
      it "returns associated user" do
        get :show, id: 'current', auth_token: user.authentication_token, format: :json
        expect(response).to be_success
        json = JSON.parse(response.body)
        expect(json['email']).to eq user.email
      end
    end

    context "with invalid auth token" do
      it "responds with unauthorized" do
        get :show, id: 'current', auth_token: user.authentication_token + 'foo', format: :json
        expect(response).not_to be_success
        expect(response.status).to eq 401
      end

    end
  end
end
