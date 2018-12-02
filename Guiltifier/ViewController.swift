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
        let price = priceTextField.text!
        print(price)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Entry", in: context)
        let newEntry = NSManagedObject(entity: entity!, insertInto: context)
        newEntry.setValue(price, forKey: "price")
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
