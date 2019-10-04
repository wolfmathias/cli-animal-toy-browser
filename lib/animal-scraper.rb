#!/usr/bin/env ruby
require "nokogiri"
require 'open-uri'
require 'pry'

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
            # open profile page and generate list of keys and values
            keys = profile.css("h3").map {|info| info.text} 
            values = profile.css("h3 + *").map {|info| info.text} 
            # iterate though hash of keys and values and set each one
            # .delete and .gsub are standardizing keys to conventional format (ie. "Fun Facts:" to fun_facts)
            i = 0 
            while i < 9
            animal[keys[i].delete('":').gsub(" ", "_").downcase.to_sym] = values[i] 
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
        AnimalScraper.scrape_animal_info(url)
    end
end

# class AnimalScraper OLD METHOD
#     #this scraper written for Out of Africa's website: https://outofafricapark.com/meet-theanimals/#

#     def self.scrape_animal_index(url)
#         animal_list = []
#         site = Nokogiri::HTML(open(url))
#         site.css("#slider_animals .animal").each do |animal|
#             animal_list << animal_info = {
#                 :species => animal.css("h2").text.delete('“”').split(', ')[0],
#                 :name => animal.css("h2").text.delete('“”').split(', ')[1],
#                 :profile_url => animal.css("a").attr("href").value
#                 } 
#         end
#         animal_list 
#     end 

#     def self.scrape_animal_info(url)
#         animal_list = AnimalScraper.scrape_animal_index(url)
#         profile_list = []
#         animal_list.each do |animal| 
#             profile = Nokogiri::HTML(open(animal[:profile_url]))
#             sex = profile.css("p strong").first.text[/\(.\)/]
#                 if sex == "(m)"
#                     animal[:sex] = "Male"
#                 elsif sex == "(f)"
#                     animal[:sex] = "Female"
#                 else
#                     sex= nil
#                 end 
#             animal[:born] = profile.css("p strong").first.text.split("born")[1].strip
#             animal[:bio] = profile.css(".post p:nth-child(6)").text
#             animal[:fun_facts] = profile.css(".post > ul").map {|fact| fact.text}

#             # binding.pry
#             # profile.css("h3").map {|info| info.text} selects all headings
#             # profile.css("h3 + *").map {|info| info.text} selects all info under headings
#             # animal_list.each do |animal|
#             #     animal.each do |key, value|
#             #         key = profile.css("h3").map {|info| info.text}
#             #         value = profile.css("h3 + *").map {|info| info.text}
#             #     end
#             # end 
#             # above is experimental code   
            

#         end
#         animal_list 
#     end

#     def self.create_animal_collection(url)
#         AnimalScraper.scrape_animal_info(url)
#     end
# end