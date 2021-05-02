import Foundation

protocol ProtocolExtended {}
extension ProtocolExtended {
    func hi() {
        print("table dispatch")
    }
}

protocol ProtocolNotExtended {
    func hi()
}

struct SomeValueType:ProtocolExtended, ProtocolNotExtended {
    func hi() {
        print("direct dispatch")
    }
    dynamic func hiDynamic() {
        print("value but message")
    }
}



class SomeRefType {
    func hiTable() {
        print("table dispatch class")
    }
    final func hiDirect() {
        print("direct dispatch class")
    }
}
extension SomeRefType {
    func hiDirectExtended() {
        print("direct dispatch class extended")
    }
    @objc
    dynamic func hiDynamic() {
        print("message dispatch class with dynamic in objc runtime")
    }
}


var a = SomeValueType()
a.hi()
a.hiDynamic()

var b:ProtocolExtended = a
b.hi()

var c:ProtocolNotExtended = a
c.hi()

var d = SomeRefType()
d.hiTable()
d.hiDirect()
d.hiDirectExtended()
d.hiDynamic()




