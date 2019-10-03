

class Donor
    attr_reader :name, :donated_toys 
    @@all = []

    def initialize(name)
        @name = name 
        @donated_toys = []
        @@all << self 
    end 

    def self.find_or_create_by_name(name)
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

    def list_donations
        self.donated_toys
    end 

    def donate(animal, toy)
        animal.toys << toy
        donated_toys << animal.toys
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