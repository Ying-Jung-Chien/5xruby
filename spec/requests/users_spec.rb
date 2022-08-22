require 'rails_helper'

RSpec.describe "users", type: :request do
  

  # let(:user) {
  #   User.create(name:"test", password:"test", position:"user")
  # }

  let(:valid_attributes) {
    {
      name:"test", 
      password:"test", 
      position:"user"
    }
  }

  let(:invalid_attributes) {
    {
      name:"", 
      password:"test", 
      position:"user"
    }
  }

  describe "GET /index" do
    it "should assgins all users to @users" do
      user = User.create(name:"test", password:"test", position:"user")
      get users_url
      expect(assigns(:users)).to eq [user]
    end
  end

  describe "GET /show" do
    it "should assigns user to @user" do
      user = User.create(name:"test", password:"test", position:"user")
      get user_url(user)
      expect(assigns(:user)).to eq user
    end
  end

  describe "GET /edit" do
    it "should assigns user to @user" do
      user = User.create(name:"test", password:"test", position:"user")
      get user_url(user)
      expect(assigns(:user)).to eq user
    end
  end

  describe "GET /new" do
    it "should assigns a new user to @user" do
      user = User.create(name:"test", password:"test", position:"user")
      get new_user_url
      expect(assigns(:user)).to be_a_new(User) 
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new user" do
        expect {
          post users_url, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it "redirects to the created user" do
        post users_url, params: { user: valid_attributes }
        expect(response).to redirect_to(users_url)
      end
    end

    # context "with invalid parameters" do
    #   it "does not create a new User" do
    #     expect {
    #       post users_url, params: { user: invalid_attributes }
    #     }.to change(User, :count).by(0)
    #   end

    #   it "should render edit template" do
    #     post users_url, params: { user: invalid_attributes }
    #     expect(response).to redirect_to(users_url)
    #   end
    # end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          name:"new", 
          password:"test", 
          position:"user"
        }
      }

      it "updates the requested user" do
        user = User.create(name:"test", password:"test", position:"user")
        patch user_url(user), params: { user: new_attributes }
        user.reload
        expect(user.name).to eq new_attributes[:name]
      end

      it "redirects to the user" do
        user = User.create(name:"test", password:"test", position:"user")
        patch user_url(user), params: { user: new_attributes }
        user.reload
        expect(response).to redirect_to(users_url)
      end
    end

    # context "with invalid parameters" do
    #   it "should render edit template" do
    #     user = User.create(name:"test", password:"test", position:"user")
    #     patch user_url(user), params: { user: invalid_attributes }
    #     expect(response).to render_template(:edit)
    #   end
    # end
  end

  describe "DELETE /destroy" do
    it "destroys the requested user" do
      user = User.create(name:"test", password:"test", position:"user")
      expect {
        delete user_url(user)
      }.to change(User, :count).by(-1)
    end

    it "redirects to the user list" do
      user = User.create(name:"test", password:"test", position:"user")
      delete user_url(user)
      expect(response).to redirect_to(users_url)
    end
  end

end
