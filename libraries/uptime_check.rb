require 'json'

module UptimeHelpers
  class UptimeCheck

    attr_reader :attributes

    WRITABLE_ATTRS = %w[name url type interval maxTime alertTreshold tags isPaused]
    READABLE_ATTRS = ['_id'] + WRITABLE_ATTRS

    def initialize(attrs = {})
      @attributes = sanitize_attrs(attrs, READABLE_ATTRS)
    end

    def record_id
      @attributes['_id']
    end

    def url
      @attributes['url']
    end

    def name
      @attributes['name']
    end

    def changed?(new_attributes = {})

    end

    def update!(new_attributes = {})
      RestClient.post("#{self.class.api_endpoint}/checks/#{record_id}", sanitize_attrs(attributes, WRITABLE_ATTRS))
    end

    def self.create!(attributes = {})
      RestClient.put("#{api_endpoint}/checks", attributes)
      return new(attributes) # Note: won't contain ID
    end

    def delete!
      RestClient.delete("#{self.class.api_endpoint}/checks/#{record_id}")
    end

    def self.find_by_url(url)
      load_all.each do |check|
        return new(check) if check['url'] == url
      end
      return nil
    end

    private

    def self.load_all
      @@checks ||= JSON.parse(RestClient.get("#{api_endpoint}/checks"))
    end

    def self.api_endpoint
      @@api_endpoint
    end

    def self.api_endpoint=(url)
      @@api_endpoint = url
    end

    # Strip any attributes that we don't write via API.
    # This normalises read data (which contains extras, with written data)
    def sanitize_attrs(attrs = {}, permitted = [])
      sanitized = {}
      attrs.each do |key, value|
        sanitized[key.to_s] = value if permitted.include?(key.to_s)
      end
      sanitized
    end

  end
end
