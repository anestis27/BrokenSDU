//
//  ViewController.swift
//  BrokenSDU
//
//  Created by Jonas Boserup on 03/11/2018.
//  Copyright © 2018 SDU. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.performSegue(withIdentifier: "loginView", sender: nil)
    }
}

