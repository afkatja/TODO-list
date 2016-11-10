//
//  SecondViewController.swift
//  TODO
//
//  Created by Katja Hollaar on 09/11/2016.
//  Copyright © 2016 Katja Hollaar. All rights reserved.
//

import UIKit

class TodoListCell: UITableViewCell {
    
    @IBOutlet weak var titleOutput: UILabel!
    @IBOutlet weak var descriptionOutput: UILabel!
    @IBOutlet weak var dueOutput: UILabel!
    @IBOutlet weak var reminderOutpu: UILabel!
}

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet weak var listView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        listView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItemsList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TodoListCell
        let item = todoItemsList[indexPath.row] 
        cell.titleOutput.text = item.titleText
        cell.descriptionOutput.text = item.descriptionText
        cell.dueOutput.text = item.due
        var check = ""
        if item.reminder == true {
            check = " ✔️"
        }
        cell.reminderOutpu.text! += check
        return cell
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            print(indexPath.row)
            todoItemsList.remove(at: indexPath.row)
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: todoItemsList)
            UserDefaults.standard.set(encodedData, forKey: "todoItemsList")
            listView.reloadData()
        }
    }
}

