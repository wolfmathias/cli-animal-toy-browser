#!/usr/bin/env ruby
require "nokogiri"
require 'open-uri'

class AnimalScraper
    #this scraper written for Out of Africa's website: https://outofafricapark.com/meet-theanimals/#

    def self.scrape_animal_index(url)
        # scrapes slider information and collect data on each entry
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
        # scrapes individual animal pages and gathers data for hash 
        animal_list = AnimalScraper.scrape_animal_index(url)
        
        animal_list.each do |animal| 
            profile = Nokogiri::HTML(open(animal[:profile_url]))
            # open profile page and generate list of keys and values
            keys = profile.css("h3").map {|info| info.text} 
            values = profile.css("h3 + *").map {|info| info.text} 
            # iterate though hash of keys and values and set each one
            # .delete and .gsub are standardizing keys to conventional format (ie. "Fun Facts:" to fun_facts)
            # regex is looking for forward slashes and ensuring only the first word is accepted (ie. "Habitat/Range" becomes "Habitat")
            # regex ensures all animal keys are standard, as some profiles choose to use listings with an additional descriptor after a forward slash
            i = 0 
            while i < 9
            animal[keys[i].delete('":').sub(/\w.+\//, '').gsub(" ", "_").downcase.to_sym] = values[i] 
            i += 1
            end
            # set remaining keys and values
            animal[:born] = profile.css("p strong").first.text.split("born")[1].strip
            sex = profile.css("p strong").first.text[/\(.\)/]
                if sex == "(m)"
                animal[:sex] = "Male"
                elsif sex == "(f)"
                animal[:sex] = "Female"           
                else
                sex= nil
                end 
        end
        animal_list 
    end

    def self.create_animal_collection(url)
        # sends collected hash to Animal object for instantiation
        AnimalScraper.scrape_animal_info(url)
    end
end