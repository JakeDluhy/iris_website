// Function whatShouldIWear
// Input: Integer day of the football season
// Output: String telling what you should wear
function whatShouldIWear(day) {
    //Check to ensure the proper data is input
    if(isNaN(day) || day !== parseInt(day, 10)) {
        return "Anything you want. That's not an integer.";
    }
    //Check modulus of days to determine what multiple it is
    if(day%7 === 0 && day%3 === 0) { //Both
        return "Let the hats rest. Wear the jersey.";
    } else if(day%3 === 0) { //Third day
        return "Wear the orange hat!";
    } else if(day%7 === 0) { //Seventh day
        return "The blue hat is your best bet.";
    } else {
        return "Please something not football related.";
    }
}