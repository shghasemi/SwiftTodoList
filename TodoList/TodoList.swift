class TodoList {
    
    static let instance = TodoList()
    var items: [Int: TodoItem]
    var labels: [String: Label]
    var nextId: Int
    
    private init() {
        self.items = [:]
        self.labels = [:]
        self.nextId = 0
    }
    
    func createItem(title: String, content: String, priority: Int) {
        let newItem = TodoItem(id: nextId, title: title, content: content, priority: priority)
        items[nextId] = newItem
        nextId += 1
    }
    
    func createLabel(name: String) -> Bool {
        if (labels[name] == nil) {
            labels[name] = Label(name: name)
            return true
        }
        return false
    }

	func getItemById(id: Int) -> TodoItem? {
		return items[id]
	}
    
}
