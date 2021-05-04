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

// list
class List<Item>: Container {
    var items = [Item]()
    var head: Item?
    var tail: Item?
    init(_ items: [Item], _ tail: Item, _ head: Item) {
        self.items = items
        self.tail = tail
        self.head = head
    }
}

class Human {
    var name: String
    var year: Int
    var prev: Human?
    var next: Human?
    init(_ name: String, _ year: Int, _ prev: Human?, _ next: Human? ) {
        self.name = name
        self.year = year
        self.prev = prev
        self.next = next
    }
}

var anna = Human("Anna", 5, nil, nil)
var olivia = Human("Olivia", 6, anna, nil)
var jake = Human("Jake", 6, olivia, nil)

anna.next = olivia
olivia.prev = anna
olivia.next = jake
jake.prev = olivia

var list = List([
        anna,
        olivia,
        jake
], anna, jake)


