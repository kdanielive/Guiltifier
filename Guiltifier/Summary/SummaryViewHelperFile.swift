//
//  SummaryViewHelperFile.swift
//  Guiltifier
//
//  Created by Daniel Kim on 12/3/18.
//  Copyright © 2018 Daniel Kim. All rights reserved.
//

import Foundation
import CoreData
import UIKit

func calculateSections() -> Int {
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return 0 }
    let managedContext = appDelegate.persistentContainer.viewContext
    let entriesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Entry")
    let entries = try! managedContext.fetch(entriesFetch) as! [Entry]
    
    var entrySet = Set<String>()
    
    for entry in entries {
        let rawTime = entry.time!
        let stringIndex = rawTime.index(rawTime.startIndex, offsetBy: 9)
        let date = String(rawTime[...stringIndex])
        
        entrySet.insert(date)
    }
    print(entrySet.count)
    return entrySet.count
}
