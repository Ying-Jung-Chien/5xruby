require 'rails_helper'

RSpec.describe "users", type: :request do
  let(:valid_attributes) {
    {
      name: "test",
      password: "Test1234@",
      position: "user"
    }
  }

  let(:invalid_attributes) {
    {
      name: "",
      password: "test",
      position: "user"
    }
  }

  before(:all) do
    @test_user = create(:user, position:"supervisor")
    post login_url, params: { "login[name]": @test_user.name, "login[password]": @test_user.password }
  end

  describe "GET /index" do
    it "should assgins all users to @users" do
      user = create(:user)
      get admin_users_url
      expect(assigns(:users)).to eq [@test_user, user]
    end
  end

  describe "GET /show" do
    it "should assigns user to @user" do
      user = create(:user)
      get admin_user_url(user)
      expect(assigns(:user)).to eq user
    end
  end

  describe "GET /edit" do
    it "should assigns user to @user" do
      user = create(:user)
      get admin_user_url(user)
      expect(assigns(:user)).to eq user
    end
  end

  describe "GET /new" do
    it "should assigns a new user to @user" do
      get new_admin_user_url
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new user" do
        expect {
          post admin_users_url, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it "redirects to the created user" do
        post admin_users_url, params: { user: valid_attributes }
        expect(response).to redirect_to(admin_users_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new User" do
        expect {
          post admin_users_url, params: { user: invalid_attributes }
        }.to change(User, :count).by(0)
      end

      it "should render new template" do
        post admin_users_url, params: { user: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          name: "new",
          password: "Test1234",
          position: "user"
        }
      }

      it "updates the requested user" do
        user = create(:user)
        patch admin_user_url(user), params: { user: new_attributes }
        user.reload
        expect(user.name).to eq new_attributes[:name]
      end

      it "redirects to the user" do
        user = create(:user)
        patch admin_user_url(user), params: { user: new_attributes }
        user.reload
        expect(response).to redirect_to(admin_users_url)
      end
    end

    context "with invalid parameters" do
      it "should render edit template" do
        user = create(:user)
        patch admin_user_url(user), params: { user: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested user" do
      user = create(:user, position:"user")
      expect {
        delete admin_user_url(user)
      }.to change(User, :count).by(-1)
    end

    it "redirects to the user list" do
      user = create(:user)
      delete admin_user_url(user)
      expect(response).to redirect_to(admin_users_url)
    end
  end
end
