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
    entriesFetch.sortDescriptors = [NSSortDescriptor.init(key: "time", ascending: true)]
    let entries = try! managedContext.fetch(entriesFetch) as! [Entry]
    
    var entrySet = Set<String>()
    
    for entry in entries {
        entrySet.insert(entry.month!)
    }
    return entrySet.count
}

func calculateRows(section : Int) -> Int {
    let entryDict = returnEntryDict()
    
    var dates = Array(entryDict.keys)
    dates = dates.sorted()
 
    return entryDict[dates[section]]!.count
}

func returnEntryDict() -> [String:[Entry]] {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
    let entriesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Entry")
    entriesFetch.sortDescriptors = [NSSortDescriptor.init(key: "time", ascending: true)]
    let entries = try! managedContext.fetch(entriesFetch) as! [Entry]
    
    var entryDict : [String:[Entry]] = [:]
    
    for entry in entries {
        let month = entry.month!
        
        if(entryDict.keys.contains(month)) {
            entryDict[month]!.append(entry)
        } else {
            entryDict[month] = [entry]
        }
    }
    
    return entryDict
}

func trimTime(rawTime: String, offset: Int) -> String {
    var stringIndex = rawTime.index(rawTime.startIndex, offsetBy: 8)
    var date = String(rawTime[stringIndex...])
    stringIndex = date.index(date.startIndex, offsetBy: offset)
    date = String(date[...stringIndex])

    
    return date
}
