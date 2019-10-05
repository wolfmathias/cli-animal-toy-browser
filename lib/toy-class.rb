class Toy
    attr_accessor :name, :price, :description, :status, :donated_to, :donated_by 
    @@all = []
    @@donated_toys = []

    def initialize(name= "Boomer Ball", price= "$30", description= "A nearly indestructible plastic ball. This one is a foot in diameter, great for all sorts of animals!")
        @status = "Waiting to be donated"
        @@all << self 
        @name = name
        @price = price 
        @description = description
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