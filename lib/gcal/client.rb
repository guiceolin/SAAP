module Gcal
  class Client < Google::APIClient
    attr_accessor :access_token, :refresh_token, :expires_at
    def initialize(access_token, refresh_token, expires_at)
      super()
      set_credentials
      self.access_token = access_token
      self.refresh_token = refresh_token
      self.expires_at = expires_at
    end

    def update_token
      self.authorization.update_token!(refresh_token: self.refresh_token, expires_in: 0 )
      self.authorization.fetch_access_token! if self.authorization.expired?
      self
    end

    def insert_calendar(summary="Gcal")
      service = self.discovered_api('calendar', 'v3')
      result = self.execute(
        api_method:  service.calendars.insert,
        parameters:  {},
        body_object: { summary: summary })
      JSON.parse(result.body)["id"]
    end

    private

    def set_credentials
      credentials = load_credentials
      self.authorization.client_id = credentials['id']
      self.authorization.client_secret = credentials['secret']
    end

    def load_credentials
      raise "Gcal Credentials config file not found!" unless File.exists?(Rails.root + "config/omniauth.yml")
      YAML.load(File.open(Rails.root + "config/omniauth.yml"))
    end
  end
end
