class Animal
    attr_accessor :name, :species, :sex, :born, :bio, :profile_url
    @@all = []

    def initialize(animal_info)
        animal_info.each {|key, value| self.send("#{key}=", value)}
        @@all << self 
    end 

    def self.all
        @@all
    end 

    def self.list_all
        Animal.all.each.with_index(1) {|animal, i| puts "#{i}. #{animal.name} the #{animal.species}"}
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
        puts
        puts "Bio: #{self.bio}"
    end

    def donate
        puts
        puts "We're sending a toy on your behalf, #{self.name} will be very happy!"
    end

    def self.create_from_url(url)
        animal_list = AnimalScraper.scrape_animal_info(url)
        animal_list.each {|animal_info| Animal.new(animal_info)}
    end 
end 