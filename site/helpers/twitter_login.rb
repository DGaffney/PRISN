module TwitterLoginHelper


  def prepare_token(redirect_path, redirect_url="http://#{Setting.twitter_callback}/twitter_callback")
    request_token = oauth_client.get_request_token( :oauth_callback => redirect_url )
    [request_token, redirect_url]
  end
  
  def get_token_credentials
    access_token = session[:request_token].get_access_token( :oauth_token => params[:oauth_token], :oauth_verifier => params[:oauth_verifier] )
    screen_name = access_token.params[:screen_name]
    oauth_token = access_token.params[:oauth_token]
    user_id = access_token.params[:user_id]
    oauth_token_secret = access_token.params[:oauth_token_secret]
    UserCredential.new(:domain => "twitter", :value => {:screen_name => screen_name, :oauth_token => oauth_token, :oauth_token_secret => oauth_token_secret, :twitter_id => user_id})
  end

  def to_twitter_oauth_url
    request_token, redirect_url = prepare_token("/twitter_callback")
    session[:request_token] = request_token
    session[:original_path] = request.referer
    redirect request_token.authorize_url(:oauth_callback => redirect_url)
  end

end