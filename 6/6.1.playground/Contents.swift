// sum
protocol Plusable {
    static func +(a: Self, b: Self) -> Self;
}

extension String: Plusable {}
extension Double: Plusable {}
extension Int: Plusable {}

func sum<Additive: Plusable>(_ a: Additive, _ b: Additive) -> Additive {
    return a + b
}

func sum<Additive1: Plusable, Additive2: Plusable>(_ a: Additive1, _ b: Additive2) -> String {
    return "\(a)" + "\(b)"
}

print(sum(40, 2))
print(sum(40.5, 1.5))
print(sum("4", "2"))
print(sum(4, "2"))
print(sum("4", 2))
print(sum(4, "2.42"))
print(sum("4", 2.42))
