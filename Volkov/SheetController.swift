//
//  SheetController.swift
//  Volkov
//
//  Created by cybek on 25/12/2019.
//  Copyright © 2019 cybek. All rights reserved.
//

import Cocoa

class SheetController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func btn(_ sender: Any) {
        self.dismiss(self)
    }
}
