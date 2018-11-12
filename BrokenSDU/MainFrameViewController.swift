//
//  MainFrameViewController.swift
//  BrokenSDU
//
//  Created by Aa on 12/11/2018.
//  Copyright © 2018 SDU. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainFrameViewController: UIViewController {

    @IBAction func logOutButton(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        }catch {
            print("There is a problem");
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
