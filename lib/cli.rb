class ToyBrowser::CLI

    def call
        puts "Choose which animal you want to buy a toy for:"
        list_animals 
        menu
        
    end 

    def list_animals
        Animal.list_all
    end 

    def list_toys
        Toy.list_all
    end 

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
                puts ""
                puts "To donate to #{current_animal.name}, type 'donate'. Or type 'list' to get back to the list of animals."
                input = nil 
                    while input != "exit" 
                        input = gets.strip.downcase  
                        if input.downcase == "donate"
                            current_animal.donate
                            puts "Do you want to donate to another animal? (y/n):"
                            input = gets.strip
                            call if input == "y"
                            thank_you if input == "n"
                        elsif input.downcase == "list"
                            call
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