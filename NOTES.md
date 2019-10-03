Command line prints a greeting and a list of toys to donate.
User selects a toy from the list to get more info.
Console prints info about that toy, and includes an option to select it for donation (or partially fund it)
Optional if time: console then prints a list of animals you can donate the toy to. Animals keep track of what toys they've received.
Console prints a thank you message OPTIONAL: each animal has custom thank you message.

Objects needed:
    Toy:
        attr: name, price, description, list of animals that received that toy
        methods: donate adds the object to animal instance and sets animal name. when animal name is set, toy is saved to list of previously donated toys.
        created manually or by scraping
        Class keeps track of all toys that have been created.

    Animal:
        attr: name, species, location, bio, list of toys received
        methods: thank you, 

Optional objects:
    Donor: 
        Class that is created by user by inputting name during gem startup. Class keeps track of what toys have been donated by user.
        "Logs in" the user if an instance of that name already exists. If not, creates new user.

NOTES:

Have "menu" be a module that either Toy or Animal class can use for list?