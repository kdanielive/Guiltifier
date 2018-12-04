//
//  SummaryViewController.swift
//  Guiltifier
//
//  Created by Daniel Kim on 12/2/18.
//  Copyright © 2018 Daniel Kim. All rights reserved.
//

import UIKit
import CoreData

class SummaryViewController: UIViewController {

    @IBOutlet var endLineView: UIView!
    @IBOutlet var endLineLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entriesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Entry")
        entriesFetch.sortDescriptors = [NSSortDescriptor.init(key: "time", ascending: true)]
        let entries = try! managedContext.fetch(entriesFetch) as! [Entry]
        
        var thisMonthPot = 0
        
        for entry in entries {
            let rawTime = entry.time!
            print(rawTime)
            var stringIndex = rawTime.index(rawTime.startIndex, offsetBy: 8)
            var date = String(rawTime[stringIndex...])
            stringIndex = date.index(date.startIndex, offsetBy: 7)
            date = String(date[...stringIndex])
            print("Date: ", date)
            
            let currentTime = Date().description(with: .current)
            print(currentTime)
            stringIndex = currentTime.index(currentTime.startIndex, offsetBy: 8)
            var currentDate = String(currentTime[stringIndex...])
            stringIndex = currentDate.index(currentDate.startIndex, offsetBy: 7)
            currentDate = String(currentDate[...stringIndex])
            print("Current Date: ", currentDate)
            
            if(date == currentDate) {
                print("yes")
                thisMonthPot += Int(entry.price!)!
            }

        }
        
        endLineLabel.text = String(thisMonthPot)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
