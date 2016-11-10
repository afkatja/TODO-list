//
//  FirstViewController.swift
//  TODO
//
//  Created by Katja Hollaar on 09/11/2016.
//  Copyright © 2016 Katja Hollaar. All rights reserved.
//

import UIKit

class TodoItems: NSObject, NSCoding {
    let titleText: String
    let descriptionText: String
    let due: String
    let reminder: Bool
    
    init(title: String, description: String, due: String, reminder: Bool) {
        self.titleText = title
        self.descriptionText = description
        self.due = due
        self.reminder = reminder
    }
    required init(coder decoder: NSCoder) {
        self.titleText = decoder.decodeObject(forKey: "titleText") as! String
        self.descriptionText = decoder.decodeObject(forKey: "description") as! String
        self.due = decoder.decodeObject(forKey: "due") as! String
        self.reminder = decoder.decodeObject(forKey: "reminder") as? Bool ?? false
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(titleText, forKey: "titleText")
        aCoder.encode(description, forKey: "description")
        aCoder.encode(due, forKey: "due")
        aCoder.encode(reminder, forKey: "reminder")
    }
}
var todoItemsList = [TodoItems]()

class FirstViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var descriptionInput: UITextField!
    @IBOutlet weak var dueInput: UITextField!
    @IBOutlet weak var alarmInput: UISegmentedControl!
    @IBAction func alarmToggle(_ sender: Any) {
        print(alarmInput.selectedSegmentIndex)
    }
    
    @IBAction func addItem(_ sender: Any) {
        dueInput.resignFirstResponder()
        var alarm = false
        if alarmInput.selectedSegmentIndex == 1 {
            alarm = true
        }
        let item = TodoItems(title: titleInput.text!, description: descriptionInput.text!, due: dueInput.text!, reminder: alarm)
        titleInput.text = ""
        descriptionInput.text = ""
        dueInput.text = ""
        alarmInput.selectedSegmentIndex = 0
        todoItemsList.append(item)
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: todoItemsList)
        UserDefaults.standard.set(encodedData, forKey: "todoItemsList")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let userdata = UserDefaults.standard.data(forKey: "todoItemsList") {
            if let decodedData = NSKeyedUnarchiver.unarchiveObject(with: userdata) as? [TodoItems] {
                todoItemsList = decodedData
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn (textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

