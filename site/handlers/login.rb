get "/login/:domain" do
  token, url = (params[:domain]+"_login").classify.constantize.prepare
  session[:request_token] = token
  redirect url
end

get "/callback/:domain" do
  binding.pry
  (params[:domain]+"_login").classify.constantize.get_credentials(params, session)
end