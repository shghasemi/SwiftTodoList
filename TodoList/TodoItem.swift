import Foundation

class TodoItem : Hashable, CustomStringConvertible {

    var id: Int
    var title = ""
    var content = ""
    var priority = 0
    var create_date: Date

    var description: String {
        get { return "[\(id)] (\(create_date)) (\(priority)) \(title): \(content)" }
    }

    static func == (lhs: TodoItem, rhs: TodoItem) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        return hasher.combine(ObjectIdentifier(self))
    }

    init(id: Int, title: String, content: String, priority: Int) {
        self.id = id
        self.title = title
        self.content = content
        self.priority = priority
        self.create_date = Date()
    }

}
