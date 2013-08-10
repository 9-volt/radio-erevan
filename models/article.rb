class Article
  include DataMapper::Resource

  property :id,       Serial
  property :source,   String
  property :time,     DateTime
  property :author,   String
  property :url,      Text
  property :category, String
  property :title,    String,  length: 255

  has n, :sentences
end
