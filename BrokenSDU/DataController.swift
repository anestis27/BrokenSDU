//
//  DataController.swift
//  BrokenSDU
//
//  Created by Emil Frisk on 06/11/2018.
//  Copyright © 2018 SDU. All rights reserved.
//

import UIKit
import CoreData
class DataController {
    
    var persistentContainer: NSPersistentContainer
    var managedObjectContext: NSManagedObjectContext
    
    static let instance = DataController(completionClosure: {})
    
    private init(completionClosure: @escaping () -> ()) {
        persistentContainer = NSPersistentContainer(name: "BrokenSDU")
        persistentContainer.loadPersistentStores() { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
            completionClosure()
        }
        managedObjectContext = persistentContainer.newBackgroundContext()
    }
    
    func createReport(description: String,
                      image: Data,
                      room: String,
                      timestamp: Date,
                      title: String,
                      userId: String) -> Report {
        let report = NSEntityDescription.insertNewObject(forEntityName: "Report", into: managedObjectContext) as! Report
        report.description_ = description
        report.image = image
        report.room = room
        report.timestamp = timestamp
        report.title = title
        report.userId = userId
        
        return report
    }
    
    func createReport(dict: [String: String], image: Data) -> Report {
        let report = NSEntityDescription.insertNewObject(forEntityName: "Report", into: managedObjectContext) as! Report
        report.description_ = dict["description"]
        report.image = image
        report.room = dict["room"]
        let dateFormatter = DateFormatter()
        report.timestamp = dateFormatter.date(from: dict["timestamp"]!)
        report.title = dict["title"]
        report.userId = dict["userId"]
        
        return report
    }
    
    func loadReports(userId: String) -> [Report] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Report")
        request.predicate = NSPredicate(format: "userId == %@", userId)
        do {
            let fetchedReports = try managedObjectContext.fetch(request) as! [Report]
            return fetchedReports
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
}
