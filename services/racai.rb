require 'savon'

class Racai
  class << self
    def client
      @client ||= Savon.client({
        :wsdl => 'http://www.racai.ro/webservices/TextProcessing.asmx?WSDL'
      })
    end

    def normalize text
      resp = client.call(:process, message: {input: text, lang: 'ro'})
      resp.body[:process_response][:process_result]
    end
  end
end
