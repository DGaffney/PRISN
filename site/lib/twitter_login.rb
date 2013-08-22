class TwitterLogin

  def self.oauth_client
    OAuth::Consumer.new(Setting.twitter_consumer_key, Setting.twitter_consumer_secret, { :site => "https://api.twitter.com" })
  end
  
  def self.prepare_token(redirect_path, redirect_url="http://#{Setting.twitter_callback}/callback/twitter")
    request_token = self.oauth_client.get_request_token( :oauth_callback => redirect_url )
    [request_token, request_token.authorize_url(:oauth_callback => redirect_url)]
  end
  
  def self.prepare
    token, url = self.prepare_token("callback/twitter")
  end

  def self.get_credentials(params, session)
    access_token = session[:request_token].get_access_token( :oauth_token => params[:oauth_token], :oauth_verifier => params[:oauth_verifier] )
    screen_name = access_token.params[:screen_name]
    oauth_token = access_token.params[:oauth_token]
    user_id = access_token.params[:user_id]
    oauth_token_secret = access_token.params[:oauth_token_secret]
    return {:domain => "twitter", :value => {:screen_name => screen_name, :oauth_token => oauth_token, :oauth_token_secret => oauth_token_secret, :twitter_id => user_id}}
  end
end