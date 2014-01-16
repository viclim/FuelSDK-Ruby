module FuelSDK::Targeting
  attr_accessor :access_token
  attr_reader :endpoint

  include FuelSDK::HTTPRequest

  def endpoint
    unless @endpoint
      determine_stack
    end
    @endpoint
  end

  def determine_stack
    options = {'params' => {'access_token' => self.access_token}}
    response = get("https://www.exacttargetapis.com/platform/v1/endpoints/soap", options)
    @endpoint = response['url']
  rescue => e
    raise 'Unable to determine stack using: ' + e.message
  end
end
