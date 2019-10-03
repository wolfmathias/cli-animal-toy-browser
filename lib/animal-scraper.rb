#!/usr/bin/env ruby
require "nokogiri"
require 'open-uri'
require 'pry'
#method still needs to be tested for return values

class AnimalScraper
    #this scraper written for Out of Africa's website: https://outofafricapark.com/meet-theanimals/#

    def self.scrape_animal_index(url)
        animal_list = []
        site = Nokogiri::HTML(open(url))
        site.css("#slider_animals .animal").each do |animal|
            animal_list << animal_info = {
                :species => animal.css("h2").text.delete('“”').split(', ')[0],
                :name => animal.css("h2").text.delete('“”').split(', ')[1],
                :profile_url => animal.css("a").attr("href").value
                } 
        end
        animal_list 
    end 

    def self.scrape_animal_info(url)
        animal_list = AnimalScraper.scrape_animal_index(url)
        profile_list = []
        animal_list.each do |animal| 
            profile = Nokogiri::HTML(open(animal[:profile_url]))
            sex = profile.css("p strong").first.text[/\(.\)/]
                if sex == "(m)"
                    animal[:sex] = "Male"
                elsif sex == "(f)"
                    animal[:sex] = "Female"
                else
                    sex= nil
                end 
            animal[:born] = profile.css("p strong").first.text.split("born")[1].strip
            animal[:bio] = profile.css(".post p:nth-child(6)").text
        end
        animal_list 
    end

    def self.create_animal_collection(url)
        AnimalScraper.scrape_animal_info(url)
    end
end