//
//  fireBase.swift
//  BrokenSDU
//
//  Created by Aa on 27/11/2018.
//  Copyright © 2018 SDU. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class FireBase {
    
    static var refReports: DatabaseReference!
    
    static func createReport(description: String,
                             
                             room: String,
                             timestamp: Date,
                             title: String,
                             userId: String) -> Bool {
        var flag = false
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        ref = db.collection("reports").addDocument(data: [
            "title":title, "description":description, "room":room,"date":timestamp, "userId":userId])
        { err in
            if let err = err {
                print("Error adding document: \(err)")
                flag = false
            } else {
                print("Document added with ID: \(ref!.documentID)")
                flag = true
            }
        }
        return flag;
    }
    
    static func getUserID() -> String{
        return Auth.auth().currentUser!.uid.description
    }
    
}
