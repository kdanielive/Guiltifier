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
        let price = priceTextField.text
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "Entry", in: managedContext)!
        let newEntry = NSManagedObject(entity: userEntity, insertInto: managedContext)
        newEntry.setValue(price, forKeyPath: "price")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        self.view.endEditing(true)
        priceTextField.text = ""
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload"), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
