require_relative '../spec_helper'

describe "shop controller" do

  describe "POST /buy" do

    before(:all) do
      @current_user = User.create(name: Faker::Name.name, address: Faker::Address.city, email:Faker::Internet.email, password: "secure", password_confirmation: "secure")
      @product = Product.create(name: Faker::Commerce.product_name, price: Faker::Commerce.price, description: Faker::Lorem.word)
     end

      describe "a user has a current order upon Login" do
        before(:all) do
          post '/login', params = {email:@current_user.email, password:"secure" }
        end

        it "Returns status 302" do
          expect(last_response.status).to eq(302)
        end

        it "Redirects to '/'" do
          last_response.should be_redirect
          follow_redirect!
          expect(last_request.url).to eq('http://example.org/')
        end

        it "User has a current_order" do
          expect(@current_user.orders.length).to eq(1)
        end
    end

    describe "can 'buy' product" do
      before(:all) do
        post '/login', params = {email:@current_user.email, password:"secure" }
        post '/buy', {product_id: @product.id}
      end

      it "Returns status 302" do
        expect(last_response.status).to eq(302)
      end

      it "Redirects to '/'" do
        last_response.should be_redirect
        follow_redirect!
        expect(last_request.url).to eq('http://example.org/')
      end

      it "adds product to cart" do
        expect(@current_user.orders.last.products).to include(@product)
      end

    end
    after(:all) do
      User.delete_all
      Product.delete_all
    end
  end
end