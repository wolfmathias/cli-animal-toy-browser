#!/usr/bin/env ruby
require 'pry'

class Donor
    attr_reader :name  
    @@all = []

    def initialize(name)
        @name = name 
        @@all << self 
    end 

    def self.find_or_create_by_name(name)
        # On CLI instantiation, donor is created or selected if donor already exists
        if Donor.all.find {|donor| donor.name == name}
        user = Donor.all.find {|donor| donor.name == name}
        else
           user = Donor.new(name)
        end 
        user 
    end 

    def self.all
        @@all
    end 

    def self.list_donations(donor)
        # user can see list of items they have previously donated and to whom
        toys = Toy.donated_toys.select {|toy| toy.donated_by == donor }
        toys.each {|toy| puts "#{toy.name} donated to #{toy.donated_to.name}."}
    end 

    def donate(animal, toy)
        # set toy.donated to/by, add toy to list of donated items
        # setting toy status to 'donated' removes that toy from the list of available toys
        # toy object instantiates new identical item to keep toy list populated
        toy.donated_to = animal
        toy.donated_by = self 
        toy.send("status=", "donated")
        puts
        puts "Thanks, #{self.name}! We're sending a toy on your behalf, #{animal.name} will be very happy!"
        donate_again?
    end 

    def donate_again?
        # submenu displayed after user donates. 
        input = nil        
        while input == nil
            puts "Do you want to return to the donation app? (y/n):"
            input = gets.strip
            if input == "y"
            ToyBrowser::CLI.new.call
            elsif input == "n"
             puts "Thank you for your support, please visit again!"
             exit 
            else
            puts "Do you want to return to the donation app? (y/n):"
            end 
        end 
    end 
end 

