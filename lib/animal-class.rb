#!/usr/bin/env ruby
require 'pry'
# Enable below line when executing file outside of ./bin/toy-browser:
# require_relative 'animal-scraper.rb' 

class Animal
    attr_accessor :name, :species, :sex, :born, :personal_info, :personal, :profile_url, :classification, :fun_facts, :habitat, :habitat, :range, :physical, :life_cycle, :behavior, :diet, :ecology_and_conservation, :ecology, :conservation_status
    @@all = []

    def initialize(animal_info)
        # expects a hash of attributes with values. Each attribute is assigned on instantiation.
        animal_info.each do |key, value| 
            self.send("#{key}=", value)
        end
        @@all << self
    end 

    def self.all
        @@all
    end 

    def self.list_all
        # generates a list of animal names and species for display in CLI
        Animal.all.each.with_index(1) do |animal, i| 
            puts
            puts "#{i}. #{animal.name} the #{animal.species}" 
        end
    end 

    def display_info
        # displays the first level of animal information
        2.times {puts}
        puts "Name: #{self.name}"
        puts "Sex: #{self.sex}"
        puts "Species: #{self.species}"
        puts "Birthday: #{self.born}"
        puts
        puts "Bio: "
        puts self.personal_info or self.personal
    end

    def self.toys_received(animal)
        # displays list of toys that animal has received, and who donated that toy.
        toys = Toy.donated_toys.select {|toy| toy.donated_to == animal}
        toys.each do |toy| 
            puts
            puts "#{toy.name} donated by #{toy.donated_by.name}." 
        end
    end 

    def self.create_from_url(url)
        # method used to create instance, pulls from scraped data
        animal_list = AnimalScraper.scrape_animal_info(url)
        animal_list.each {|animal_info| Animal.new(animal_info)}
    end 
end 