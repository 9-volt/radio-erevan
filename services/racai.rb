require 'savon'

class Racai
  attr_reader :client
  def initialize wsdl='http://www.racai.ro/webservices/TextProcessing.asmx?WSDL'
    @client = Savon.client(:wsdl => wsdl)
  end

  def normalize word
    resp = @client.call(:process, message: {input: word, lang: 'ro'})
    resp.body[:process_response][:process_result]
  end

  def normalize_words words
    normalize(words.join(' ')).split(' ')
  end
end
