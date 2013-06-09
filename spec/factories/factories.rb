require 'spec_helper'

FactoryGirl.define do
  factory :url, class: URL do
    url     'spec/fixtures/unimedia_article.html'
    source  'unimedia'
  end
end
