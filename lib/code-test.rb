#!/usr/bin/env ruby
require "nokogiri"
require 'open-uri'
require 'pry'

doc = Nokogiri::HTML(open("https://www.thegentlemansjournal.com/five-worst-financial-crashes-time/"))
doc.css("div p strong").map {|e| e.text}
binding.pry