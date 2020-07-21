# ToyBrowser

This application was the first 'Hello World' app I created without a tutorial. Showcasing my knowledge of object oriented programming paradigms, the app uses Animal, Donor, and Toy classes that interact with eachother. It also keeps track of users with the name attribute of a Donor instance, setting that instance of Donor as the user and allows different users to be created and "logged in".

## Creating the Toys and Animals

When running 'toy-browser.rb', `toy_list` is defined as an array of hashes. This array is then passed to the `create_from_collection` method of the Toy class, which iterates of the array and creates a Toy instance with each hash. 

```
class Toy
    def initialize(toy_hash)
        toy_hash.each {|key, value| self.send("#{key}=", value)}
        @status = "Waiting to be donated"
        # @attributes is hash, info is used to instantiate new identical object when status is changed to 'donated'
        @attributes = {name: self.name, price: self.price, description: self.description}
        @@all << self
    end

    def self.create_from_collection(collection)
        collection.each do |toy_hash| 
            Toy.new(toy_hash)
        end
    end

end
```

Once these toys are created, the animals are created in a similar fashion with the `Animal.create_from_url(url)` class method. A separate `AnimalScraper` class is used to handle getting the animal info with its `scrape_animal_index` and `scrape_animal_info` instance methods. I'll go over scraping in another section.

## Creating the user

Before interacting with the app, we first need to create or select a user. This is done with a simple name attribute. The input is passed to the class method `Donor.find_or_create_by_name(name)`, which checks an array of all the users and either returns the user with a matching name, or creates a new one.

```
    def self.find_or_create_by_name(name)
        # On CLI instantiation, donor is created or selected if donor already exists
        if Donor.all.find {|donor| donor.name == name}
        user = Donor.all.find {|donor| donor.name == name}
        else
           user = Donor.new(name)
        end 
        user 
    end
```


## Using the app

After these collections are created, the application truly starts by creating a new instance of ToyBrowser and using the `call` method on it, which prints a list of animals and a menu.

```
# inside 'class ToyBrowser::CLI'

    def call
        2.times {puts} # gives some whitespace for spacing 
        puts "Choose which animal you want to buy a toy for:"
        sleep 1 # wait one second before printing list of animals
        puts
        list_animals 
        menu
    end 

    def list_animals
        Animal.list_all
    end

    def menu
        # print statements and logic to handle CLI menu
    end

```

Above in `list_animals`, `Animal.list_all` is called. This class method iterates over an array of all the animals (created by pushing each instance into the array when initialized), then prints the name of each one next to an index number.

The `menu` method uses a 'while' loop to keep some if/else conditionals repeating, which all check for certain input from the terminal.

```
    def menu
        # Display list of animals. User enters number to select animal or can list toys already donated by user
        # Selecting animal displays that individual animal's information and prompts for donation
        input = nil
        puts
        puts "Enter the number next to an animal to see more info:"
        puts "Enter 'donations' to see toys you have already donated."
        while input != "exit"
            input = gets.strip
            if input.to_i <= Animal.all.count && input.to_i > 0  
                current_animal = Animal.all[input.to_i-1]
                current_animal.display_info
                puts
                self.display_animal_profile_menu(current_animal)
                input = "" 
                while input.downcase != "exit"
                    input = gets.strip.downcase

                    # several line of if/else to check for input like "habitat" or "diet"
                    
                end
            elsif input.downcase == "donations"
            puts
            Donor.list_donations(@user)
            puts
            elsif input.downcase == "exit"
            thank_you 
            else 
            puts "Please enter the number next to an animal:"
            end 
        end
    end 
```

Above, `input` is initially set to nil. Then we loop inside `while input != "exit"`. With this 
## Installation

This README assumes Ruby and the Ruby gem 'Bundler' are installed on your machine.

Clone the repo and navigate to the newly created directory. Install dependencies using bundler.

`git clone git@github.com:bigcatplichta/cli-data-gem-portfolio-project.git`

`cd ./cli-data-gem-portfolio-project.git`

`bundle install`

Run the 'toy-browser' file inside '/bin'

`ruby bin/toy-browser`

## Usage

Usage is guided by the program when running bin/toy-browser.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` is not needed as tests have not yet been written for this gem. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bigcatplichta/cli-data-gem-portfolio-project.

## License

Copyright 2019 MATT PLICHTA

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
