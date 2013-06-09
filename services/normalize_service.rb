class NormalizeService
  class << self
    def normalize_sentences sentences
      text = sentences.join('. ')
      response = Racai.normalize text

      response.split('. ').map do |ns|
        ns.split(' ').map do |racai_flags|
          parts = racai_flags.split('|')
          {
            :initial_form => parts[0],
            :normalized_form => parts[1],
            :racai_response => racai_flags
          }
        end.select do |hash|
          hash[:initial_form] != '.'
        end
      end
    end
  end
end
