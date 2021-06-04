import Foundation


class Controller {
    var cmd: [String] = []
    var todoList = TodoList.instance
    
    func run() {
        while true {
            print("$ ", terminator: "")
            cmd = readLine()!.components(separatedBy: " ")
            
            switch cmd[0] {
            
            case "exit":
                exit(0)
            
            case "help":
                print("HELP")
            
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
            print("label \(name) already exists")
        }
    }
    
    func editItem() {
        print("EDIT")
    }
    
    func deleteItem() {
        let id = Int(cmd[2])
        if (todoList.items[id!] != nil) {
            todoList.items[id!] = nil
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
