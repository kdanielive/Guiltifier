//
//  ViewController.swift
//  Guiltifier
//
//  Created by Daniel Kim on 11/29/18.
//  Copyright © 2018 Daniel Kim. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet var chargeButton: UIButton!
    @IBOutlet var priceTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        chargeButton.layer.cornerRadius = 5
        chargeButton.layer.borderWidth = 0.5
        chargeButton.layer.borderColor = UIColor.blue.cgColor
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if(priceTextField.text == "") {
            let alert = UIAlertController(title: "Retry", message: "Enter a valid price", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let price = priceTextField.text
            
            // block code for time
            let now = Date()
            // month
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM"
            let month = dateFormatter.string(from: now)
            // day
            dateFormatter.dateFormat = "dd"
            let day = dateFormatter.string(from: now)
            // clock
            dateFormatter.dateFormat = "h:mm a"
            let clock = dateFormatter.string(from: now)
            // shortHand Month
            dateFormatter.dateFormat = "MMM"
            let shortMonth = dateFormatter.string(from: now)
            
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            let userEntity = NSEntityDescription.entity(forEntityName: "Entry", in: managedContext)!
            let newEntry = NSManagedObject(entity: userEntity, insertInto: managedContext)
            newEntry.setValue(price, forKeyPath: "price")
            newEntry.setValue(month, forKeyPath: "month")
            newEntry.setValue(day, forKeyPath: "day")
            newEntry.setValue(clock, forKeyPath: "clock")
            newEntry.setValue(shortMonth, forKey: "shortMonth")
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
            self.view.endEditing(true)
            priceTextField.text = ""
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload"), object: nil)
        }
    }
    
    @IBAction func deleteAll(_ sender: UIBarButtonItem) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Entry")
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        do {
            try managedContext.execute(request)
            print("succeeded")
        } catch {
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
