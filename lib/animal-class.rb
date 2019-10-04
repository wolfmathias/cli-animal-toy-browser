class Animal
    attr_accessor :name, :species, :sex, :born, :bio, :profile_url
    @@all = []

    def initialize(animal_info)
        animal_info.each do |key, value| 
            self.send("#{key}=", value)
        end
        @@all << self
    end 

    def self.all
        @@all
    end 

    def self.list_all
        Animal.all.each.with_index(1) do |animal, i| 
            puts
            puts "#{i}. #{animal.name} the #{animal.species}" 
        end
    end 

    def display_info
        puts
        puts
        puts
        puts "Name: #{self.name}" 
        puts "Sex: #{self.sex}"
        puts "Species: #{self.species}"
        puts "Birthday: #{self.born}"
        puts
        puts "Bio: #{self.bio}"
    end

    def self.toys_received(animal)
        # display list of toys that animal has received, and who donated that toy.
        toys = Toy.donated_toys.select {|toy| toy.donated_to == animal}
        toys.each do |toy| 
            puts
            puts "#{toy.name} donated by #{toy.donated_by.name}." 
        end
    end 

    def self.create_from_url(url)
        animal_list = AnimalScraper.scrape_animal_info(url)
        animal_list.each {|animal_info| Animal.new(animal_info)}
    end 
end 