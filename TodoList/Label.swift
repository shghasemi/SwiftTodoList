class Label {
    
    var name: String
    var items: Set<TodoItem?>
    
    init(name: String) {
        self.name = name
        self.items = []
    }
    
    func addItem(item: TodoItem) {
        self.items.insert(item)
    }
    
}
