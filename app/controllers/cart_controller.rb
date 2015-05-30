before '/cart' do
  @current_user = User.find(session[:id])
  @current_order = @current_user.orders.last
end

get '/cart' do

  @contents = @current_order.products.to_a unless @current_user.orders.last.current == 'f'
  @cart_count = @current_order.products.length

  if @contents && @cart_count != 0
    @total = @contents.map { |product| product.price.to_f }.reduce(:+)
  else
    @total = 0
  end

  erb :cart
end

post '/buy-now' do
  current_user = User.find(session[:id])
  current_order = current_user.orders.last
  @current_order.current = false
  @current_order.save
  @current_user.orders << Order.create(current: true)
  flash[:cart] = "The contents of your cart has been successfully purchased"
  redirect '/cart'
end

post '/remove' do
  current_user = User.find(session[:id])
  current_order = current_user.orders.last
  item = Product.find(params[:product_id])
  @current_order.products.delete(item)
  flash[:remove] = "An item was successfull removed from your cart"
  redirect '/cart'
end