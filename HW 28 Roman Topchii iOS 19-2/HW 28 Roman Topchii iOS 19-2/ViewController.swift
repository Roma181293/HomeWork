//
//  ViewController.swift
//  HW 28 Roman Topchii iOS 19-2
//
//  Created by Roman Topchii on 15.02.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView1: UITableView!
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var taskList : [Task] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        tableView1.reloadData()
    }
    
    func addTask(text : String) {
        print(#function)
        
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Task", in: managedContext) else {return}
        
        let task = NSManagedObject(entity: entityDescription, insertInto: managedContext) as! Task
        
        //заполняем данными экземпляр модели
        task.text = text
        taskList.append(task)
        tableView1.reloadData()
        
        do {
            try managedContext.save()
            //если использовать tableView, то тут вызвать
            //tableView.insertRows(at: [IndexPath(row: list.count-1, section: 0)], with: .automatic)
        }
        catch let error {
            print("SAVE ERROR: ", error.localizedDescription)
        }
    }
    
    
    func fetchData() {
        print(#function)
        
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        do {
            taskList = try managedContext.fetch(fetchRequest)
            
            tableView1.reloadData()
            
            //выдать данные на экран
            for (index, element) in taskList.enumerated() {
                print(index, element.text)
            }
            
        }
        catch let error {
            print("FETCH ERROR: ", error.localizedDescription)
        }
    }
    
    func deleteTaskWithIndex(_ index : Int) {
        if index >= 0 && taskList.count > index {
            let entityForDelete = taskList[index]
            managedContext.delete(entityForDelete)
            do {
                try managedContext.save()
                print("taskList[\(index)] deleted")
                taskList.remove(at: index)
            }
            catch let error {
                print("DELETE ERROR: ", error.localizedDescription)
            }
        }
        else {
            print("There is not entityList[\(index)]")
            return
        }
    }
    
    func deleteAllTask() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results {
                if let managedObjectData: NSManagedObject = managedObject as? NSManagedObject {
                    managedContext.delete(managedObjectData)
                }
            }
            print("All task deleted")
            try managedContext.save()
            
        } catch let error as NSError {
            print("Deleted all my data in Task error : \(error) \(error.userInfo)")
        }
    }
    
    
    
    
    @IBAction func addnewTaskAction() {
        
        let alert = UIAlertController(title: "Enter task text", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Example: meet somebody"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            if let tmp = alert!.textFields![0].text, tmp != "" {
                self.addTask(text: String(describing: tmp))
                self.fetchData()
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func deleteAllTaskAction() {
        print(#function)
        deleteAllTask()
        fetchData()
    }
}



extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_ID",for: indexPath)
        cell.textLabel?.text = taskList[indexPath.row].text!
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteTaskWithIndex(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}


