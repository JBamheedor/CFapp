require 'rails_helper'

describe ProductsController, type: :controller do

  describe 'GET #show' do
    before do
      @product = FactoryBot.create(:product)
      @user = FactoryBot.create(:user)
    end

    context 'site visitor accesses specific products without needing to login' do
      it 'loads correct product details' do
        get :show, params: { id: @product.id }
        expect(response).to be_ok
        # checks that in our controller we set the @product instance variable to the expected user.
        # expect the assigned :product to equal the product we created
        expect(assigns(:product)).to eq @product
        expect(response).to have_http_status(200)
        expect(response).to render_template("show")
      end
    end
  end

  describe 'GET #index' do
    before do
      @product = FactoryBot.create(:product)
      @user = FactoryBot.create(:user)
    end

    context 'renders index to all users' do
      it 'loads all product details' do
        get :index
        expect(response).to be_ok
        expect(response).to render_template("index")
      end
    end
  end

  describe 'GET #new' do
    before do
      @user_admin = FactoryBot.create(:admin)
      @user = FactoryBot.create(:user)
    end

    context "When the user is admin" do
      before do
        sign_in @user_admin
      end
      it "renders the new template" do
        get :new
        expect(response).to be_ok
        expect(response).to render_template("new")
      end
    end

    context "When user is not admin and logged in" do
      before do
        sign_in @user
      end
      it "redirects to root path" do
        get :new
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #edit' do
    before do
      @product = FactoryBot.create(:product)
      @user_admin = FactoryBot.create(:admin)
      @user = FactoryBot.create(:user)
    end
    context "When the user is admin" do
      before do
        sign_in @user_admin
      end
      it "renders the edit template" do
        get :edit, params: {id: @product.id}
        expect(response).to be_ok
        expect(response).to render_template("edit")
      end
    end
    context "When user is not admin and logged in" do
      before do
        sign_in @user
      end
      it "redirects to root path" do
        get :edit, params: {id: @product.id}
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end
    end
    context "When a user is not admin and not logged in" do
      it "redirects to login" do
        get :edit, params: {id: @product.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end


  describe 'POST #create'do
    before do
      @product = FactoryBot.create(:product)
      @admin_user = FactoryBot.create(:admin)
      sign_in @admin_user
    end

    context 'Creating new product as admin' do
      it 'creates product' do
      post :create, params: { product: { name: @product.name, description: @product.description, price: @product.price, image_url: @product.image_url, color: @product.color} }
      expect(response).to redirect_to(:action => :show, :id => assigns(:product).id)
      #    Expects the params we have declared to be an object
      expect(assigns(:product)).to be_a(Product)
      end
    end

    context 'Inputting incorrect params (name)' do
      it "is an invalid missing name" do
        @product = FactoryBot.build(:product, name: "")
        expect(@product).not_to be_valid
      end
    end
  end

  describe 'PUT/PATCH #update'do

    before do
      @product = FactoryBot.create(:product)
    end

    context 'Updating a product as admin' do
      it 'updates product' do
        @admin_user = FactoryBot.create(:admin)
        sign_in @admin_user
        @update = { name: "Bike2"}
        post :update, params: {id: @product.id, product: @update }
        @product.reload
        expect(@product.name).to eq "Bike2"
      end
    end

    context 'Attempting to update not logged in or admin' do
      it 'updates product' do
        @update = { name: "Bike2"}
        post :update, params: {id: @product.id, product: @update }
        @product.reload
        expect(@product.name).not_to eq "Bike2"
      end
    end
  end

  describe 'DELETE #destroy'do
    context 'Deletes product' do
      it 'deletes product' do
        @product = FactoryBot.create(:product)
        @admin_user = FactoryBot.create(:admin)
        sign_in @admin_user
        delete :destroy, params: {id: @product.id}
        expect(response).to redirect_to products_path
      end
    end
  end
end
