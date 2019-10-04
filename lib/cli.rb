require 'readline'

class ToyBrowser::CLI
    attr_reader :user 

    def initialize
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
        list_animals 
        menu
        
    end 

    def list_animals
        Animal.list_all
    end 

    def list_toys(current_animal)
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

    # def donate_again?
    #     # submenu displayed after user donates. 
    #     input = nil        
    #     while input == nil
    #         puts "Do you want to donate to another animal? (y/n):"
    #         input = gets.strip
    #         if input == "y"
    #         call
    #         elsif input == "n"
    #         thank_you
    #         else
    #         puts "Do you want to donate to another animal? (y/n):"
    #         end 
    #     end 
    # end 

    def thank_you
        puts "Thank you! Come back again!"
        exit
    end

    def menu
        input = nil
        puts "Enter the number to see more info, or type exit:"
        
        while input != "exit"
            input = gets.strip
            if input.to_i <= Animal.all.count && input.to_i != 0  
                current_animal = Animal.all[input.to_i-1]
                current_animal.display_info
                puts 
                puts "To donate to #{current_animal.name}, type 'donate'. Or type 'list' to get back to the list of animals."
                puts "You can also type 'donations' to see a list of items you have already donated."
                input = nil 
                while input != "exit" 
                    input = gets.strip.downcase  
                    if input.downcase == "donate"
                    #Display list of available toys to donate to specific animal. Toys are own class of objects.
                    #When toy is chosen, 'donated by' and 'donated to' attrs are set.
                    list_toys(current_animal)
                    elsif input.downcase == "list"
                    call
                    #elsif input == "donations"
                    
                    elsif input == "exit"
                    thank_you
                    else 
                    puts "Please type 'donate' or 'list'."
                    end  
                end
            elsif input == "exit"
            thank_you 
            else 
            puts "Please enter the number next to an animal:"
            end 
        end
    end 

    
end 