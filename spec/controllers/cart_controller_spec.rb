require_relative '../spec_helper'

describe "cart controller" do

  describe "POST /buy" do

    before(:all) do
      @current_user = User.create(name: Faker::Name.name, address: Faker::Address.city, email:Faker::Internet.email, password: "secure", password_confirmation: "secure")
      @product = Product.create(name: Faker::Commerce.product_name, price: Faker::Commerce.price, description: Faker::Lorem.word)
        post '/login', params = {email:@current_user.email, password:"secure" }
        post '/buy', {product_id: @product.id}
        get '/cart'
     end

      describe "a user can view their cart" do

        it "Returns status 200" do
          expect(last_response.status).to eq(200)
        end
      end

      describe "a user can remove an item from the cart" do
        before(:all) do
          post '/remove', {product_id: @product.id}
        end

        it "Returns status 302" do
          expect(last_response.status).to eq(302)
        end

        it "order should no longer include product" do
          expect(@current_user.orders.last.products).to_not include(@product)
         end
      end

      describe "a user can buy the contents of cart" do
        before(:all) do
          get '/'
          post '/buy', {product_id: @product.id}
          get '/cart'
          post '/buy-now'
        end

        it "Returns status 302" do
          expect(last_response.status).to eq(302)
        end

        it "a new order of 0 lenght has been sent up" do
          expect(@current_user.orders.last.products.length).to eq(0)
         end

      end
  end
end