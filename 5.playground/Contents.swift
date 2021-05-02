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
}



class SomeRefType {
    func hiTable() {
        print("table dispatch class")
    }
    final func hiDirect() {
        print("direct dispatch class")
    }
}
extension SomeRefType:ProtocolExtended {
    func hiDirectExtended() {
        print("direct dispatch class extended")
    }
    dynamic func hiDynamic() {
        print("message dispatch with dynamic")
    }
}


var a = SomeValueType()
a.hi()

var b:ProtocolExtended = a
b.hi()

var c:ProtocolNotExtended = a
c.hi()

var d = SomeRefType()
d.hiTable()
d.hiDirect()
d.hiDirectExtended()
d.hiDynamic()




