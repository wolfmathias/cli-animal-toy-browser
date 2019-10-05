require 'readline'

class ToyBrowser::CLI
    attr_reader :user 

    def initialize
        # Accepts user's name and instantiates new donor object with name
        puts "Welcome! Let's start with getting your name:"
        name = nil 
        while name == nil
            name = gets.strip 
            @user = Donor.find_or_create_by_name(name)
        end 
    end

    def call
        2.times {puts}
        puts "Choose which animal you want to buy a toy for:"
        puts
        list_animals 
        menu
        
    end 

    def list_animals
        Animal.list_all
    end 

    def list_toys(current_animal)
        2.times {puts}
        puts "Please pick a toy to send to #{current_animal.name}:"
        # List option of toys to select from. Selecting a toy adds that object instance to animal's list of donated items.
        # User can choose to go back to animal list to donate again or exit application.
        Toy.list_all
        input = nil
        while input != "exit"
            input = gets.strip
            if input.to_i <= Toy.all.count && input.to_i != 0
            current_toy = Toy.all[input.to_i-1]
            @user.donate(current_animal, current_toy) #add method argument to add toy to animal's list of donated items
            elsif input == "list"
            call 
            elsif input == "exit"
            thank_you 
            else
            puts "Please select the number next to a toy."
            end
        end
    end 

    def thank_you
        puts "Thank you! Come back again!"
        exit
    end

    def menu
        # Display list of animals. User enters number to select animal or can list toys already donated by user
        # Selecting animal displays that individual animal's information and prompts for donation
        input = nil
        puts
        puts "Enter the number to see more info, or type exit:"
        puts "Enter 'donations' to see toys you have already donated."
        while input != "exit"
            input = gets.strip
            if input.to_i <= Animal.all.count && input.to_i != 0  
                current_animal = Animal.all[input.to_i-1]
                current_animal.display_info
                puts
                puts 
                puts "Navigation:  "
                puts "'donate': donate to #{current_animal.name}      'list': go back to list of animals.        'toys': display list of toys already owned by #{current_animal.name}"
                input = nil 
                while input.downcase != "exit" 
                    input = gets.strip.downcase  
                    if input.downcase == "donate"
                    #Display list of available toys to donate to specific animal
                    #When toy is chosen, 'donated by' and 'donated to' attrs are set.
                    list_toys(current_animal)
                    elsif input.downcase == "list"
                    call
                    elsif input == "toys"
                    puts 
                    Animal.toys_received(current_animal)
                    puts
                    puts "Hit 'Enter' to return to navigation."
                    elsif input.downcase == "exit"
                    thank_you
                    else 
                    puts "Please type 'donate', 'list', or 'toys'."
                    end  
                end
            elsif input.downcase == "donations"
            puts
            Donor.list_donations(@user)
            puts
            puts "Hit 'Enter' to return to navigation."
            elsif input.downcase == "exit"
            thank_you 
            else 
            puts "Please enter the number next to an animal:"
            end 
        end
    end 
end 