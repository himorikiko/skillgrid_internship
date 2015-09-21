require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  render_views

  before {
    sign_in FactoryGirl.create :user
  }

  let(:created_product) { create :product }

  describe "GET #edit" do
    it "assigns the created_product as @product" do
      get :edit, id: created_product.id
      expect(assigns(:product)).to eq created_product
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:attrs_list) { [:title, :description] }
      let(:new_attributes) { {
        title:      'Titttle',
        description: 'Descrrrription',
      } }

      def update_with_valid_params
        put :update, id: created_product.id, product: new_attributes
      end

      it "updates the created_product" do
        attrs_list.each do |attrb|
          expect(created_product.send(attrb.to_s)).not_to eq new_attributes[attrb] # sanity check
        end

        update_with_valid_params
        created_product.reload

        attrs_list.each do |attrb|
          expect(created_product.send(attrb.to_s)).to eq new_attributes[attrb]
        end
      end

      it "assigns the created_product as @product" do
        update_with_valid_params
        expect(assigns(:product)).to eq created_product
      end

      it "redirects to the example" do
        update_with_valid_params
        expect(response).to redirect_to(created_product)
      end
    end
  end
end
