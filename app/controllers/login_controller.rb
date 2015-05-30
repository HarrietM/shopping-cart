require 'sanitize'

get '/' do
  if session[:id]
    @products = Product.all
    current_user = User.find(session[:id])

    if current_user.orders.last == nil || current_user.orders.last.current == 'f'
      current_user.orders << Order.create(current: true)
    end
    @cart_count = current_user.orders.last.products.length
    erb :home
    else
    erb :login
  end
end

post '/login' do
  params.each_value{ |value| value.replace(Sanitize.clean(value)) }

  user = User.find_by(email: params[:email]).try(:authenticate, params[:password])
  if user
    session[:id] = user.id
  else
    flash[:login] = "Oops! You have entered incorrect details."
  end
  redirect '/'
end

post '/signup' do
  params.each_value{ |value| value.replace(Sanitize.clean(value)) }

  user = User.new(address: params[:address], email: params[:email], name: params[:name], password: params[:password], password_confirmation: params[:password_confirmation] )
  if user.valid?
    user.save
  else
    flash[:error_list] = user.errors.messages
  end
  if user
    session[:id] = user.id
  end
  redirect '/'
end

get '/logout' do
  session[:id] = nil
  redirect '/'
end