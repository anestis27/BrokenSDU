//
//  FirebaseDataController.swift
//  BrokenSDU
//
//  Created by Emil Frisk on 28/11/2018.
//  Copyright © 2018 SDU. All rights reserved.
//

import Foundation
import Firebase

class FirebaseDataController: DataControllerProtocol {
    
    
    var ref: DatabaseReference!
    let storage = Storage.storage()
    let coreDataController = DataController.instance
    
    static let instance = FirebaseDataController()
    
    private init() {
        ref = Database.database().reference()
    }
    
    func createReport(description: String, image: Data, room: String, timestamp: Date, title: String, userId: String) -> Report {
        return coreDataController.createReport(description: description, image: image, room: room, timestamp: timestamp, title: title, userId: userId)
    }
    
    func saveReport(report: Report) {
        self.ref.child("reports").childByAutoId().setValue(report.toDict()) { (error: Error?, ref: DatabaseReference) in
            if let key = ref.key {
                let imageRef = self.storage.reference().child("images/\(key).jpg")
                if let image = report.image {
                    imageRef.putData(image, metadata: nil) { (metadata, error) in
                        if error != nil {
                            print("Couldn't upload the image for report with id: \(key)")
                        }
                    }
                }
            }
        }
    }
    
    func loadReports(userId: String, completion: @escaping (Report) -> ()) {
        self.ref.child("reports").queryOrdered(byChild: "userId").queryEqual(toValue: userId).observeSingleEvent(of: .value, with: { snapshot in
            for case let reportSnapshot as DataSnapshot in snapshot.children {
                let reportDict = reportSnapshot.value as! [String: String]
                let imageRef = self.storage.reference().child("images/\(reportSnapshot.key).jpg")
                imageRef.getData(maxSize: 2 * 1024 * 1024) { data, error in
                    if error != nil {
                        print("Couldn't read image for report with id: \(reportSnapshot.key)")
                    } else {
                        let report = self.coreDataController.createReport(dict: reportDict, image: data!)
                        completion(report)
                    }
                }
            }
        })
    }
}
