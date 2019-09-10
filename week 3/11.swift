
import Foundation

class PersonAddress {
    var firstName : String
    var lastName : String
    var address : String
    var city : String
    var state : String
    var zip : String
    var phoneNumber : String
    
    init(_ firstName : String, _ lastName : String, _ address : String, _ city : String, _ state : String, _ zip: String, _ phoneNumber : String) {
        self.firstName = firstName
        self.address = address
        self.city = city
        self.lastName = lastName
        self.state = state
        self.zip = zip
        self.phoneNumber = phoneNumber
    }
    
}

class AddressBook {
    var addressBook = [PersonAddress]()
    
    init() {
        let newPerson = addNewPerson()
        addressBook.append(newPerson)
    }
    
    func addNewPerson () -> PersonAddress {
        print("Enter the first name of the person to be added to address book")
        let firstName = readLine()!
        print("Enter the last name of the person")
        let lastName = readLine()!
        print("Enter the address of the person")
        let address = readLine()!
        print("Enter the city of the person")
        let city = readLine()!
        print("Enter the zip code")
        let zip = readLine()!
        print("Enter the state of the person")
        let state = readLine()!
        print("Enter the phoneNumber of the person")
        let phoneNumber = readLine()!
        
        var temporaryPersonAddress = PersonAddress(firstName,lastName,address,city,state, zip,phoneNumber)
        
        return temporaryPersonAddress
        
    }
    
    func editExistingInformation() {
        print("Enter the first name and last name of the person whose adress has to be edited")
        let firstName = readLine()!
        let lastName = readLine()!
        
        for person in addressBook {
            if person.firstName == firstName && person.lastName == lastName {
                 print("Enter the field be edited")
                let fieldToBeEdited = readLine()!
                
                switch fieldToBeEdited {
                case "address" :
                    person.address = readLine()!
                case "city" :
                    person.city = readLine()!
                case "zip" :
                    person.zip = readLine()!
                case "state" :
                    person.state = readLine()!
                case "phoneNumber" :
                    person.phoneNumber = readLine()!
                default :
                    print("Invalid field name")
                }
                
            }
        }
        
    }
    
    func deletePerson() {
        print("Enter the first name and last name of the person whose address has to be deleted")
        let firstName = readLine()!
        let lastName = readLine()!
        var index = -1
        for person in addressBook {
            index += 1
            if person.firstName == firstName && person.lastName == lastName {
                    addressBook.remove(at: index)
                
            }
        }
    }
    
    func sortByLastName() {
        addressBook.sort(by: { $0.lastName < $1.lastName })
    }
    
    func sortByZipCode() {
        addressBook.sort(by: { $0.zip < $1.zip})
    }
    
    func printAddressBook() {
        for person in addressBook {
            print("\(person.firstName)")
            print("\(person.lastName)")
            print("\(person.address)")
            print("\(person.city)")
            print("\(person.state)")
            print("\(person.zip)")
            print("\(person.phoneNumber)")
        }
    }
    
    func performAnOperation() {
        var exitFlag = false
        while exitFlag == false {
            print("Choose the operation to be performed.")
            print("")
            print("1 : Add a new person to address book.")
            print("2 : Edit existing information about a person,except his name.")
            print("3 : Delete a person's records from address book")
            print("4 : Sort entries of address book in alphabetical order of last name")
            print("5 : Sort entries of address book in increasing order of zip code")
            print("6 : Print the address book in mailing label format")
            print("7 : Exit")
            let operation = readLine()!
            if operation == "1" {
                let temporaryPersonAddress = addNewPerson ()
                addressBook.append(temporaryPersonAddress)
            }
            if operation == "2" {
                editExistingInformation()
            }
            if operation == "3" {
                deletePerson()
            }
            if operation == "4" {
                sortByLastName()
            }
            if operation == "5" {
                sortByZipCode()
            }
            if operation == "6" {
                printAddressBook()
            }
            if operation == "7" {
                exitFlag = true
            }
        }
    }
}


let newAddressBook = AddressBook()
newAddressBook.performAnOperation()
