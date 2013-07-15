require 'spec_helper'

describe SessionsController do
  include Devise::TestHelpers

  let(:user) { FactoryGirl.create :user }

  describe "POST #create" do
    context "with valid params" do
      it "returns authentication token" do
        post :create, email: user.email, password: user.password, format: :json
        expect(response).to be_success
        json = JSON.parse(response.body)
        expect(json['authentication_token']).not_to be_blank
        expect(json['authentication_token']).to eq user.reload.authentication_token
      end
    end

    context "with invalid params" do
      it "returns errors" do
        post :create, email: user.email, password: user.password + 'foo', format: :json
        expect(response).not_to be_success
        expect(response.status).to eq 422
        json = JSON.parse(response.body)
        expect(json['errors']).not_to be_blank
      end
    end
  end


  describe "DELETE #destroy" do
    before { user.reset_authentication_token! }

    context "with valid auth token" do
      it "invalidates given token" do
        delete :destroy, id: 'current', auth_token: user.authentication_token, format: :json
        expect(response).to be_success
        expect(user.reload.authentication_token).to be_nil
      end
    end

    context "with invalid auth token" do
      it "responds with unauthorized" do
        delete :destroy, id: 'current', auth_token: user.authentication_token + 'foo', format: :json
        expect(response).not_to be_success
        expect(response.status).to eq 401
      end

    end
  end
end
