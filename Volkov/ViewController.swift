//
//  ViewController.swift
//  Volkov
//
//  Created by cybek on 25/12/2019.
//  Copyright © 2019 cybek. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func btn(_ sender: Any) {
        let segue = "segueSheet"
        self.performSegue(withIdentifier: segue, sender: nil)
    }
    
}

