class UptimeApiCall

  class << self
    attr_accessor :uptime_checks

    def api_endpoint
      "#{node['app_uptime']['url']}/api"
    end

    def load_all_checks
      # UptimeApiCall.uptime_checks ||=
    end

    def check_exists?(url)

    end

    def create_check(attributes = {})

    end

    def update_check(id, attributes={})

    end

    def delete_check(id)

    end

  end
end
