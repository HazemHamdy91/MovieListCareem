//
//  StorageManager.swift
//  MovieListCareem
//
//  Created by Hazem Hamdy on 9/1/18.
//  Copyright © 2018 Hazem Hamdy. All rights reserved.
//

import UIKit
import CoreData


class StorageManager: NSObject {
    
    
    static func getQuriesHistory() -> [String] {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return [String]()
        }
        
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "History")
        
        
        do {
            var historyManaged = try managedContext.fetch(fetchRequest)
            historyManaged = historyManaged.reversed()
            var historyStrings = [String]()
            // defaine max size to be 10 or the count of returned results
            if historyManaged.count > 0
            {
                let maxRange = min(historyManaged.count-1, 9)
                for i in  0...maxRange
                {
                    let nsManagedObject = historyManaged[i]
                    historyStrings.append(nsManagedObject.value(forKeyPath: "query") as? String ?? "")
                }
            }
            return historyStrings
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return[String]()
    }
    
    
    static func saveSuccessfulQuery(query:String)  {
        // Check if query Exist
        let historyArr = self.getQuriesHistory()
        if historyArr.contains(query)
        {
            return
        }
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entity(forEntityName: "History", in: managedContext)!
        let queryRow = NSManagedObject(entity: entity, insertInto: managedContext)
        queryRow.setValue(query, forKeyPath: "query")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
}
