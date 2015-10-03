require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views

  before {
    sign_in FactoryGirl.create :user
  }

  let(:current_user) { controller.current_user }

  describe "GET #edit" do
    it "assigns the current_user as @user" do
      get :edit, id: current_user.id
      expect(assigns(:user)).to eq current_user
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:attrs_list) { [:name, :last_name] }
      let(:new_attributes) { {
        name:      'User Name',
        last_name: 'User Last Name',
      } }

      def update_with_valid_params
        put :update, id: current_user.id, user: new_attributes
      end

      it "updates the current_user" do
        attrs_list.each do |attrb|
          expect(current_user.send(attrb.to_s)).not_to eq new_attributes[attrb] # sanity check
        end

        update_with_valid_params
        current_user.reload

        attrs_list.each do |attrb|
          expect(current_user.send(attrb.to_s)).to eq new_attributes[attrb]
        end
      end

      it "assigns the current_user as @user" do
        update_with_valid_params
        expect(assigns(:user)).to eq current_user
      end

      it "redirects to the example" do
        update_with_valid_params
        expect(response).to redirect_to(current_user)
      end
    end
  end
end
