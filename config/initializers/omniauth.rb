OmniAuth.config.full_host = "http://localhost:3000"
raise "omniauth config file not found!" unless File.exists?(Rails.root + "config/omniauth.yml")
credentials = YAML.load(File.open(Rails.root + "config/omniauth.yml"))

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, credentials['id'], credentials['secret'], :scope => 'userinfo.email,userinfo.profile,calendar'
end
