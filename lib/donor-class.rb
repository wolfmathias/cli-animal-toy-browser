#!/usr/bin/env ruby

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
        if toys.count == 0
            puts "You haven't donated anything yet!" 
        else 
            toys.each do |toy| 
                puts
                puts "#{toy.name} donated to #{toy.donated_to.name} the #{toy.donated_to.species}." 
            end
        end
        puts
        puts "Enter the number next to an animal to see more info:"
    end 

    def donate(animal, toy)
        # set toy.donated to/by, add toy to list of donated items
        # setting toy status to 'donated' removes that toy from the list of available toys
        # toy object instantiates new identical item to keep toy list populated
        toy.donated_to = animal
        toy.donated_by = self 
        toy.send("status=", "donated")
        puts
        puts "Thanks, #{self.name}! We're sending a #{toy.name} on your behalf, #{animal.name} will be very happy!"
        puts "Enrichment is an important part of an animal's life. It keeps them mentally engaged and healthy."
        puts
        donate_again?
    end 

    def donate_again?
        # submenu displayed after user donates
        input = ""        
        while input == ""
            puts "Do you want to return to the donation app? (y/n):"
            input = gets.strip.downcase
            if input == "y" || input == "yes"
            ToyBrowser::CLI.new.call
            elsif input == "n" || input == "no" || input == "exit"
             puts "Thank you for your support, please visit again!"
             exit 
            else
            puts "Do you want to return to the donation app? (y/n):"
            input = ""
            end 
        end 
    end 
end 

