protocol Container {
    associatedtype Item
    var items: [Item] { get set }
    var count: Int { get }
    mutating func append(_ item: Item);
    subscript(_ index: Int) -> Item? {get}
}

extension Container {
    var count: Int {
        return items.count
    }
    mutating func append(_ item: Item) {
        items.append(item)
    }
    subscript(_ i: Int) -> Item? {
        count > i ? items[i] : nil
    }
}

// q
struct Seq<Item>: Container {
    var items = [Item]()
    mutating func deq() -> Item? {
        count > 0 ? items.removeFirst() : nil
    }
}

//var seq = Seq<Int>()
//print(seq[4])
//seq.append(5)
//print(seq[0])
//print(seq.deq())
//print(seq.deq())
//print("--\n")

// list
class List<Item>: Container {
    var items = [Item]()
    var head: Item?
    var tail: Item?
    init(_ items: [Item], _ tail: Item?, _ head: Item?) {
        self.items = items
        self.tail = tail
        self.head = head
    }
}

protocol Listable {
    var prev: Listable? {get set}
    var next: Listable? {get set}
}

extension List where Item:Listable {
    func append(_ item: Item) {
        if (self.head != nil) {
            self.head!.next = item
        }
        if (self.tail == nil) {
            self.tail = item
        }
        self.head = item
        items.append(item)
    }
}

class Human:Listable {
    var name: String
    var age: Int
    var prev: Listable?
    var next: Listable?
    init(_ name: String, _ age: Int) {
        self.name = name
        self.age = age
    }
}

var anna = Human("Anna", 5)
var olivia = Human("Olivia", 12)
var jake = Human("Jake", 6)

var list = List([Human](), nil, nil)
list.append(anna)
list.append(olivia)
list.append(jake)

typealias People = List<Human>

func printPeople(_ l: People) {
    var current:Listable? = list.tail
    while current != nil {
        let human = current as! Human
        print(human.name)
        current = current!.next
    }
    print("--")
}

func findOldest(_ l: People) -> Human? {
    var current:Listable? = list.tail
    var oldest = current as! Human?
    while current != nil {
        let human = current as! Human
        if (human.age > (oldest != nil ? oldest!.age : 0)) {
            oldest = human
        }
        current = current!.next
    }
    return oldest
}

printPeople(list)

list.append(Human("Jose", 8))
printPeople(list)

if let oldest = findOldest(list) {
    print(oldest.name, oldest.age)
}

