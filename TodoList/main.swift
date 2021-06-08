import Foundation

//Todo handle exceptions
class Controller {
    var cmd: [String] = []
    var todoList = TodoList.instance

	func showHelp() {
		print()
		print("List of available commands:")
		print("create item:     create a todo item")
		print("create label:    create a label for todos")
		print("show items:      show all todos")
		print("show label:      show a specific label of todos")
		print("edit:            edit a todo")
		print("delete:          delete a todo")
		print("sort:            sort todos by time/title/priority and ascending/descending")
		print("add:             add one or more todos to a label")
		print("exit:            terminate and exit program")
		print()
	}
    
    func run() {
        while true {
			showHelp()
            print("$ ", terminator: "")
            cmd = readLine()!.components(separatedBy: " ")
            
            switch cmd[0] {
            
            case "exit":
                exit(0)
            
            case "create":
                switch cmd[1] {
                case "item":
                    createItem()
                case "label":
                    createLabel()
                default:
                    print("invalid command")
                }
            
            case "edit":
                editItem()
                
            case "delete":
                deleteItem()
                
            case "show":
                switch cmd[1] {
                case "items":
                    showItems()
                case "label":
                    showLable()
                default:
                    print("invalid command")
                }
            
            case "sort":
                sortItems()
                showItems()
            
            case "":
                break
            
            default:
                print("invalid command")
            }
        }
    }
    
    func createItem() {
        print("- title: ", terminator: "")
        let title = readLine()!
        print("- content: ", terminator: "")
        let content = readLine()!
        print("- priority: ", terminator: "")
        let priority = Int(readLine()!)!
        todoList.createItem(title: title, content: content, priority: priority)
    }
    
    func createLabel() {
        print("- name: ", terminator: "")
        let name = readLine()!
        if (!todoList.createLabel(name: name)) {
            print("label \(name) already exists!")
        }
    }
    
    func editItem() {
        print("- item id: ", terminator: "")
		let id = Int(readLine()!)!
		let item = todoList.getItemById(id: id)
		if (item == nil) {
			print("item not exists!")
			return
		}
		print("- new title: ", terminator: "")
		let newTitle = readLine()!
		if (newTitle != "") {
			item!.title = newTitle
		}
		print("- new content: ", terminator: "")
		let newContent = readLine()!
		if (newContent != "") {
			item!.content = newContent
		}
		print("- new priority: ", terminator: "")
		let newPriority = readLine()!
		if (newPriority != "") {
			item!.priority = Int(newPriority)!
		}
    }
    
    func deleteItem() {
		print("- item id: ", terminator: "")
        let id = Int(readLine()!)!
        if (todoList.items[id] != nil) {
            todoList.items[id] = nil
        } else {
            print("invalid item id \(String(describing: id))")
        }
    }
    
    func showItems() {
        for (_, item) in todoList.items {
            print("* \(item)")
        }
    }
    
    func showLable() {
//        let label = todoList.labels[cmd[2]]
        print("LABEL")
    }
    
    func sortItems() {
        print("SORT")
    }
    
    func addLabel() {
        print("ADD LABEL")
    }
}

let controller = Controller()
controller.run()
