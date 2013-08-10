#!/usr/bin/env ruby

require 'open-uri'
require 'nokogiri'

xml = open('http://jurnal.md/ro/rss.xml').read

filename = 'data/' + Time.now.strftime('%Y-%m-%d.xml')
fullpath = File.expand_path(File.dirname(__FILE__),
                            filename)
File.open(fullpath, 'w') do {|f| f.write(xml) }


