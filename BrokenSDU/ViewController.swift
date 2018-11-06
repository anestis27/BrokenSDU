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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Show beacon test view controller
        let vc = BeaconTestController()
        self.present(vc, animated: true, completion: nil)
    }


}

