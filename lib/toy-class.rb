class Toy
    attr_accessor :name, :price, :description, :status 
    @@all = []

    def initialize
        @status = "Waiting to be donated"
        @@all << self 
    end 

    def self.all
        @@all
    end 

    def self.list_all
        @@all.each.with_index(1) do |toy, i| 
            puts "#{i}. #{toy.name} -- #[toy.price}"
            puts "Description: #{toy.description}"
        end
    end 

    def display_info
        puts self.name
        puts self.price
        puts self.description
    end 

    def self.new_from_site

    end 
end 