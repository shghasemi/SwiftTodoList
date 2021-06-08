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
		print("add:             add one or more existing todo item/items to a label")
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
                    showLabel()
                default:
                    print("invalid command")
                }

            case "sort":
                let column = cmd[1]
                let order = cmd[2]
                sortItems(column: column, order: order)

			case "add":
				addToLabel()

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
		print(" [id] (priority) title: content")
        for (_, item) in todoList.items {
            print("* \(item)")
        }
    }

    func showLabel() {
		print("- label name: ", terminator: "")
		let labelName = readLine()!
		let label = todoList.getLabelByName(name: labelName)
		if (label == nil) {
			print("label doesn't exist!")
			return
		}
		for item in label!.items {
			print("* \(item)")
		}
    }

    func sortItems(column: String, order: String) {
        var sortedItems: Array<(key: Int, value: TodoItem)>
        if (order == "ASC") {
            switch column {
                case "create_date":
                    sortedItems = todoList.items.sorted(by: { $0.value.create_date < $1.value.create_date })
                case "priority":
                    sortedItems = todoList.items.sorted(by: { $0.value.priority < $1.value.priority })
                case "title":
                    sortedItems = todoList.items.sorted(by: { $0.value.title < $1.value.title })
                default:
                    print("invalid command")
                    return
            }
        } else {
            switch column {
                case "create_date":
                    sortedItems = todoList.items.sorted(by: { $0.value.create_date > $1.value.create_date })
                case "priority":
                    sortedItems = todoList.items.sorted(by: { $0.value.priority > $1.value.priority })
                case "title":
                    sortedItems = todoList.items.sorted(by: { $0.value.title > $1.value.title })
                default:
                    print("invalid command")
                    return
            }
        }
        print(" [id] (create_date) (priority) title: content")
        for (_, item) in sortedItems {
            print("* \(item)")
        }
        print("SORT COMPLETED")
    }

    func addToLabel() {
        print("- label name: ", terminator: "")
		let labelName = readLine()!
		let label = todoList.getLabelByName(name: labelName)
		if (label == nil) {
			print("label doesn't exist!")
			return
		}
		print("- item ids (seperated by space): ", terminator: "")
		let ids = readLine()!.components(separatedBy: " ")
		for id in ids {
			let item = todoList.getItemById(id: Int(id)!)
			if (item == nil) {
				print("invalid item id \(id)")
				continue
			}
			label!.addItem(item: item!)
		}
    }
}

let controller = Controller()
controller.run()
