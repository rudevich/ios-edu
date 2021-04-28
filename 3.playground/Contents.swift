import UIKit

class Logger {
    private var logs:[String];

    init() {
        print("\nInit logger")
        logs = []
    }
    public func log(_ log: String) {
        logs.append(log)
    }
    public func get() -> [String] {
        return logs
    }
}

struct Mult {
    private var _m: Double?;
    var m: Double {
        get {
            _m ?? 0
        }
        set (newMultipler) {
            _m = newMultipler;
            if (!isKnownUniquelyReferenced(&logger)) {
                logger = Logger()
            }
        }
    }
    var logger: Logger = Logger();

    subscript(i: Double) -> Double {
        let result = m * i
        logger.log("Multipler: \(m), Value: \(result)")
        return result
    }

    init(_ multipler: Double) {
        m = multipler;
    }
}
let five = Mult(5)
print("Set multipler to: \(five.m)")
five[1]; five[2]; five[3]; five[4]; five[5];

var five2 = five
print("Don't set new multipler")
print(five.logger === five2.logger ? "Same logger" : "Different logger")

var six = five
six.m = 6;
print("Set multipler to: \(six.m)")
six[5]; six[10];
print(six.logger === five.logger ? "Same logger" : "Different logger")
