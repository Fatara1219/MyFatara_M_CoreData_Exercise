//
//  ViewController.swift
//  MyFatara_M_CoreData_Exercise
//
//  Created by Fatara Muhammad on 8/12/20.
//  Copyright © 2020 Fatara Muhammad. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class ViewController: UIViewController {
    
    var dataManager : NSManagedObjectContext!
    var listArray = [NSManagedObject]()
    
    @IBAction func saveRecordButton(_ sender:UIButton) {
        
        let newEntity = NSEntityDescription.insertNewObject(forEntityName: "Item", into: dataManager)
        newEntity.setValue(enterVanGogh.text!, forKey: "about")
        
        do{
            try self.dataManager.save()
            listArray.append(newEntity)
        } catch {
            print ("Error saving data")
        }
        displayDataHere.text?.removeAll()
        enterVanGogh.text?.removeAll()
        fetchData()
    }
    
    
    @IBAction func deleteRecordButton(_ sender:UIButton) {

            let deleteItem = enterVanGogh.text!
            for item in listArray {
                if item.value(forKey: "about") as! String == deleteItem {
                    dataManager.delete(item)
                }
                do {
                    try self.dataManager.save()
                } catch {
                    print ("Error deleting data")
                }
                displayDataHere.text?.removeAll()
                enterVanGogh.text?.removeAll()
                fetchData()
        }
    }
    
    @IBOutlet var enterVanGogh: UITextField!
    
    
    @IBOutlet var displayDataHere: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataManager = appDelegate.persistentContainer.viewContext
        displayDataHere.text?.removeAll()
        fetchData()
    }
    func fetchData() {
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> =
        NSFetchRequest(entityName: "Item")
        do {
            let result = try dataManager.fetch(fetchRequest)
            listArray = result as! [NSManagedObject]
            for item in listArray {
                
                let product = item.value(forKey: "about") as! String
                displayDataHere.text!
                += product
            }
        } catch {
print ("Error retrieving data")
}

}
}
