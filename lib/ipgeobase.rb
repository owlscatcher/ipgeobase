# frozen_string_literal: true

require "addressable/uri"
require "net/http"
require "nokogiri-happymapper"
require_relative "ipgeobase/version"

# This is top level documentation
module Ipgeobase
  class Error < StandardError; end

  API_URL = "http://ip-api.com/xml"

  def self.lookup(ip_address)
    uri = Addressable::URI.parse("#{API_URL}/#{ip_address}")
    response = Net::HTTP.get_response(uri)

    HappyMapper.parse(response.body)
  end
end
