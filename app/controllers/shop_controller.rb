post '/buy' do
  current_user = User.find(session[:id])

  if current_user.orders.last == nil || current_user.orders.last.current == 'f'
    current_user.orders << Order.create(current: true)
  end

  current_order = current_user.orders.last
  item = Product.find(params[:product_id])

  current_order.ordered_products << OrderedProduct.create(order_id: current_order.id, product_id: item.id)

  flash[:bought] = "An item was added to your cart!"

  redirect '/'
end

get '/:id' do
  @product = Product.find(params[:id])
  @cart_count = User.find(session[:id]).orders.last.products.length
  erb :product
end

