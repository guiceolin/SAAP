module Gcal
  class Settings
    DEFAULT_OPTIONS = { id_column: :gcalendar_id, access_token: :access_token, refresh_token: :refresh_token }
    attr_accessor :klass, :options, :client
    attr_accessor :id, :access_token, :refresh_token, :summary
    def initialize(klass, options)
      self.klass = klass
      self.options = options.reverse_merge!(DEFAULT_OPTIONS)
      extract_options(self.options)
      build_client
    end

    def build_client
      self.client = Gcal::Client.new(self.access_token, self.refresh_token, 0)
    end

    def to_hash
      {
        id: id,
        summary: summary
      }
    end

    private

    def extract_options(options)
      self.summary = options.delete(:summary) || 'Gcal Calendar'
      extract_id(options[:id_column])
      extract_access_token(options[:access_token])
      extract_refresh_token(options[:refresh_token])
    end

    def extract_id(id_column = :gcalendar_id)
      self.id = klass.send(id_column)
    end

    def extract_access_token(acces_token_column)
      self.access_token = klass.send(acces_token_column)
    end

    def extract_refresh_token(refresh_token_column)
      self.refresh_token = klass.send(refresh_token_column)
    end

  end
end
