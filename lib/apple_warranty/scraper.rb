
require 'apple_warranty/errors'

module AppleWarranty
  # Apple Warranty Info Scraper
  class Scraper
    attr_reader :errors

    def initialize
      @errors = []
      @warranty_expired = false
      @data_fetched = false
    end

    # return false on error
    def get_data(imei)
      return false unless valid?(imei)
      begin
        content  = open("https://selfsolve.apple.com/wcResults.do?sn=#{imei}&num=0") { |f| f.read }.split("\n")
      rescue StandardError => e
        @errors << e.message
        return false
      end

      parse(content)
    end

    def warranty_active?
      !warranty_expired?
    end

    def warranty_expired?
      ensure_data_is_fetched
      @warranty_expired || @warranty_expired_at < Date.today
    end

    def warranty_expired_at
      ensure_data_is_fetched
      @warranty_expired_at
    end

    protected

    def format_imei(imei)
      imei.upcase.gsub('O', '0')
    end

    def valid?(imei)
      (format_imei(imei) =~ /^[0-9A-Z]{10,15}$/) == 0
    end

    def ensure_data_is_fetched
      fail AppleWarranty::Errors::DataNotFetchedError unless @data_fetched
    end

    def parse(content)
      data = content.detect { |el| el =~ /displayHWSupportInfo/ }

      if data.nil?
        @errors << 'displayHWSupportInfo not found'
        return false
      end

      @data_fetched = true

      begin
        date_str = data.match(%r{Expiration Date:(.*)<br/>})[1]
        @warranty_expired_at = Date.parse(date_str)
      rescue StandardError
        @warranty_expired = true
        return true
      end

      @care_plus = data.scan(/AppleCare\+/).length > 0
    end
  end
end
