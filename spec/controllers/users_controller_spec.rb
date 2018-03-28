require 'rails_helper'

describe UsersController, type: :controller do

  describe 'GET #show' do
      @user = User.create!(email: "jonny@example.com", password: "1234567890")
      @user2 = User.create!(email: "maryjane@example.com", password: "123456")

    context 'when a user is logged in' do

      before do
        sign_in @user
      end

      it 'loads correct user details' do
        get :show, params: { id: @user.id }
        expect(response).to be_ok
        expect(assigns(:user)).to eq @user
      end

      it 'cannot load other users details' do
        get :show, params: { id: @user2.id}
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end

    end

    context 'when a user is not logged in' do

      it 'redirects to login page' do
        get :show, params: { id: user.id }
        expect(response).to redirect_to(new_user_session_path)
      end



    end


  end

end
