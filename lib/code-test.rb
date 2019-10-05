#!/usr/bin/env ruby
require "nokogiri"
require 'open-uri'
require 'pry'

class Toy
    attr_accessor :name, :price, :description, :status, :donated_to, :donated_by 
    @@all = []
    @@donated_toys = []

    def initialize(toy_hash)
        @status = "Waiting to be donated"
        toy_hash.each {|key, value| self.send("#{key}=", value)}
        @@all << self
        binding.pry
    end 

    def self.create_from_collection(collection)
        collection.each {|toy_hash| Toy.new(toy_hash)}
    end

    def self.all
        @@all
    end 

    def self.donated_toys
        @@donated_toys
    end 

    def self.list_all
        # creates list for CLI 
        @@all.each.with_index(1) do |toy, i| 
            puts "-----------------------------------"
            puts "#{i}. #{toy.name} -- #{toy.price}"
            puts "Description: #{toy.description}"
            puts "-----------------------------------"
            sleep 0.05
        end
    end 

    def display_info
        puts self.name
        puts self.price
        puts self.description
    end 

    def status=(status)
        # When toy is donated, remove it from list of all toys and add it to list of donated toys
        # then generate new Toy object with same attributes
            @status = "donated"
            @@donated_toys << self 
            @@all.delete(self)
            Toy.new(name= self.name, price= self.price, description= self.description)
        
    end 
end 

toy_list = [
    {name: "Boomer Ball",
    price: "$30",
    description: "A nearly indestructible plastic ball. This one is a foot in diameter, great for all sorts of animals!"
    },
    {name: "Bungee Toy",
    price: "$20",
    description: "A durable stretchy firehose. Attach it to a fixture for a game of tug of war."
    },
    {name: "Hammock",
    price: "$80",
    description: "A hammock made of interwoven straps. Lounge around while eating bamboo shoots!"
    },
    {name: "Firehose Cube",
    price: "$10",
    description: "Recycled firehose woven into a dense, heavy cube. Good for strong animals."
    },
    {name: "Floaty Toy",
    price: "$25",
    description: "Buoyant toy, great for marine animals or anyone who likes to play in the pool."
    },
    {name: "Treat Dispenser",
    price: "$30",
    description: "This rolls around, dropping delicious treats as it goes."
    },
    {name: "Tube",
    price: "$10",
    description: "It's a tube. Small animals can crawl inside it. Large animals can stick their head in it. Tuuuuuuuuubbbbeeee!!!"
    },
    {name: "Puzzle Box",
    price: "$40",
    description: "Kind of like those toddler toys. Put the square peg into the square hole. Good for monkeys."
    },
    {name: "Rope swing",
    price: "$20",
    description: "Attach this to the ceiling of an enclosure. Animals can swing on it or grab it and pull it."
    },
    {name: "Hidey-hole",
    price: "$15",
    description: "Small box with a hole, kind of like a fort."
    },
    {name: "Crinkly Bag",
    price: "$30",
    description: "Durable bag that makes noises when scrunching it, great for cats."
    }]

    Toy.create_from_collection(toy_list)