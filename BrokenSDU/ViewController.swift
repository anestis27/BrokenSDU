//
//  ViewController.swift
//  BrokenSDU
//
//  Created by Jonas Boserup on 03/11/2018.
//  Copyright © 2018 SDU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.performSegue(withIdentifier: "loginView", sender: nil)
    }


}

