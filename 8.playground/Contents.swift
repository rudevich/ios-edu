import UIKit

var ar = [1,2,3]

extension Array {
}

struct Settings {
    static let shared = Settings()
    var username: String?

    private init() {
    }
}
var a = Settings.shared
a.username = "Nick"
var b = Settings.shared
b.username = "Bob"
print(a.username, b.username)
