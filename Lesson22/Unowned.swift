import Foundation

// MARK: - Бесхозные (unowned) ссылки

class Customer {
    let name : String
    var card : CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("Customer \(name) deinit") }
}

class CreditCard {
    let number : UInt64
    unowned let customer : Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Credit Card #\(number) deinit") }
}

var user : Customer?
user = Customer(name: "Alex") // создали сильную ссылку на Customer
user?.card = CreditCard(number: 1234567890123456, customer: user!) // создали сильную ссылку на CreditCard
// но CreditCard ссылается на Customer по безхозной ссылке!

// user?.card = nil - разрушит сильную ссылку на CreditCard и уничтожит CreditCard
user = nil // разрушит сильную ссылку на Customer и т.к он больше не будет иметь сильных ссылок (ссылка с CreditCard на него - безхозная, то есть не сильна) уничтожит Customer. А раз Customer уничтожен, то его сильная ссылка на CreditCard также удалится и уничтожит сам экземпляр CreditCard


// MARK: - Бесхозные ссылки + неявноизвлеченные опционалы

class Country {
    let name: String
    var capitalCity : City!
    
    init(name: String, capital: String) {
        self.name = name
        self.capitalCity = City(name: capital, country: self)
    }
    deinit { print("      Country \(name) deinit") }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
    deinit { print("      City \(name) deinit") }
}

var russia : Country? = Country(name: "Russia", capital: "Moscow")

print("      " + russia!.capitalCity.name) // обращение к опциональному свойству capitalCity без разворачивания
russia = nil
