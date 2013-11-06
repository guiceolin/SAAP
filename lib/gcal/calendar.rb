module Gcal
  class Calendar
    attr_accessor :user, :id, :client, :name
    def initialize(name, user, id)
      self.name = name
      self.user = user
      self.id = id
      initialize_client
    end

    def persist
      if persisted?
        false
      else
        insert
      end
    end

    def persisted?
      !!self.id
    end

    private

    def insert
      self.id = client.update_token.insert_calendar(name)
    end

    def initialize_client
      self.client = Client.new(user.oauth_access_token,
                               user.oauth_refresh_token,
                                 user.oauth_expires_in )
    end

  end
end
