//
//  ViewController.swift
//  Guiltifier
//
//  Created by Daniel Kim on 11/29/18.
//  Copyright © 2018 Daniel Kim. All rights reserved.
//

import UIKit

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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

