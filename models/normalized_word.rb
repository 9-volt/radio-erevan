class NormalizedWord
  include DataMapper::Resource

  property :id,               Serial    # An auto-increment integer key
  property :initial_form,     String    # A varchar type string, for short strings
  property :normalized_form,  String    # A text block, for longer string data.
  property :racai_flags,      String    # A text block, for longer string data.
end
