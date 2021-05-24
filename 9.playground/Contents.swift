import UIKit

// строитель
protocol UserProtocol {
    var name: String? { get }
    var surname: String? { get }
}

protocol UserBuilderProtocol {
    func buildUser(_ name: String?, _ surname: String?) -> UserProtocol
}

extension UserProtocol {
    func getFullName() -> String {
        return (self.name ?? "[notset]") + " " + (self.surname ?? "[notset]")
    }
}

class User: UserProtocol {
    var name: String?
    var surname: String?
    init(_ name: String?, _ surname: String?) {
        self.name = name
        self.surname = surname
    }
}

class UserBuilder: UserBuilderProtocol {
    func buildUser(_ name: String?, _ surname: String?) -> UserProtocol {
        return User(name, surname)
    }
}

let builder = UserBuilder()
let user = builder.buildUser("Вася", "Васин")
print(user.getFullName())

// fabric
protocol Human {
    func eat()
    func drink()
}

class Boy: Human {
    func eat() {
        print("поел")
    }
    func drink() {
        print("попил")
    }
}

class Girl: Human {
    func eat() {
        print("поела")
    }
    func drink() {
        print("попила")
    }
}

protocol Female {
    var concieved: Bool { get set }
    func conceive(_ dad: AnyObject)
    func bornBoy() -> Boy?
    func bornGirl() -> Girl?
}

class Mom: Female {
    var concieved = false
    
    func conceive(_ dad: AnyObject) {
        concieved = true
    }
    
    func bornBoy() -> Boy? {
        if (!concieved) {
            print("неа")
            return nil
        }
        print("у нас мальчик")
        concieved = false
        return Boy()
    }
    
    func bornGirl() -> Girl? {
        if (!concieved) {
            print("неа")
            return nil
        }
        print("у нас девочка")
        concieved = false
        return Girl()
    }
}

let mom = Mom()
let boy = mom.bornBoy()
mom.conceive(NSObject())
let girl = mom.bornGirl()
