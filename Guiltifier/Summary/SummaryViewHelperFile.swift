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
        let date = trimTime(rawTime: entry.time!, offset: 9)
        entrySet.insert(date)
    }
    print("section num: ", entrySet.count)
    return entrySet.count
}

func calculateRows(section : Int) -> Int {
    let entryDict = returnEntryDict()
    
    var dates = Array(entryDict.keys)
    dates = dates.sorted()
    print(entryDict[dates[section]]!.count)
 
    return entryDict[dates[section]]!.count
}

func returnEntryDict() -> [String:[Entry]] {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
    let entriesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Entry")
    let entries = try! managedContext.fetch(entriesFetch) as! [Entry]
    
    var entryDict : [String:[Entry]] = [:]
    
    print(entries.count, "count")
    for entry in entries {
        let date = trimTime(rawTime: entry.time!, offset: 6)
        print("1: ", date)
        
        if(entryDict.keys.contains(date)) {
            entryDict[date]!.append(entry)
            print("this shouldn't")
        } else {
            entryDict[date] = [entry]
            print("this should print")
        }
    }
    
    return entryDict
}

func trimTime(rawTime: String, offset: Int) -> String {
    let stringIndex = rawTime.index(rawTime.startIndex, offsetBy: offset)
    let date = String(rawTime[...stringIndex])
    
    return date
}
