require 'spec_helper'

describe TasksController do
  include Devise::TestHelpers

  let(:user) do
    user = FactoryGirl.build :user
    user.ensure_authentication_token!
    user
  end

  describe "GET #index" do
    before { FactoryGirl.create_list(:task, 5, user: user) }

    context "with valid auth token" do
      it "returns list of user tasks" do
        get :index, auth_token: user.authentication_token, format: :json
        expect(response).to be_success
        json = JSON.parse(response.body)
        expect(json.size).to eq 5
        expect(json[0]['title']).to eq user.tasks.first.title
      end
    end

    context "without auth token" do
      it "responds with unauthorized" do
        get :index, format: :json
        expect(response).not_to be_success
        expect(response.status).to eq 401
      end
    end
  end


  describe "POST #create" do
    context "with valid auth token" do
      it "creates and returns the task" do
        post :create, auth_token: user.authentication_token, title: 'My task', priority: 1, format: :json
        expect(response).to be_success
        user.tasks.reload
        expect(user.tasks.count).to eq 1
        expect(user.tasks.first.title).to eq 'My task'
        expect(user.tasks.first.priority).to eq 1
        json = JSON.parse(response.body)
        expect(json['title']).to eq 'My task'
        expect(json['priority']).to eq 1
      end
    end

    context "without auth token" do
      it "responds with unauthorized" do
        post :create, title: 'My task', priority: 1, format: :json
        expect(response).not_to be_success
        expect(response.status).to eq 401
      end
    end
  end


  describe "PATCH #update" do
    let(:task) { FactoryGirl.create :task, user: user }

    context "with valid auth token" do
      it "updates the task" do
        patch :update, auth_token: user.authentication_token, id: task.id, title: 'My task', done: true, format: :json
        expect(response).to be_success
        task.reload
        expect(task.title).to eq 'My task'
        expect(task.done).to be_true
      end
    end

    context "without auth token" do
      it "responds with unauthorized" do
        patch :update, id: task.id, title: 'My task', done: true, format: :json
        expect(response).not_to be_success
        expect(response.status).to eq 401
      end
    end

    context "with not existing task id" do
      it "responds with not found" do
        patch :update, auth_token: user.authentication_token, id: task.id + 1, title: 'My task', done: true, format: :json
        expect(response).not_to be_success
        expect(response.status).to eq 404
      end
    end
  end


  describe "DELETE #destroy" do
    let(:task) { FactoryGirl.create :task, user: user }

    context "with valid auth token" do
      it "delete the task" do
        delete :destroy, auth_token: user.authentication_token, id: task.id, format: :json
        expect(response).to be_success
        expect(user.tasks.reload.size).to eq 0
      end
    end

    context "without auth token" do
      it "responds with unauthorized" do
        delete :destroy, id: task.id, format: :json
        expect(response).not_to be_success
        expect(response.status).to eq 401
      end
    end

    context "with not existing task id" do
      it "responds with not found" do
        delete :destroy, auth_token: user.authentication_token, id: task.id + 1, format: :json
        expect(response).not_to be_success
        expect(response.status).to eq 404
      end
    end
  end


end
