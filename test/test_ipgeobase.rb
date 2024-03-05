# frozen_string_literal: true

require "test_helper"
require "ipgeobase"

class TestIpgeobase < Minitest::Test
  def setup
    @ip = "8.8.8.8"
    @stub = stub_request(:get, "#{Ipgeobase::API_URL}/#{@ip}")
            .with(headers: { "Accept" => "*/*", "User-Agent" => "Ruby" })
            .to_return(status: 200, body: load_fixture("successfull_response.xml"), headers: {})
  end

  def test_that_it_has_a_version_number
    refute_nil ::Ipgeobase::VERSION
  end

  def test_lookup_http_query
    Ipgeobase.lookup(@ip)

    assert_requested @stub
  end

  def test_loockup_body_successful
    assert(Ipgeobase.lookup("8.8.8.8").status == "success")
  end

  def test_lookup_body_city
    assert(Ipgeobase.lookup(@ip).city == "Ashburn")
  end
end
