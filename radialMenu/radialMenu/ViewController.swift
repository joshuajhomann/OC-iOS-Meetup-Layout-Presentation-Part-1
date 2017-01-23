//
//  ViewController.swift
//  radialMenu
//
//  Created by Joshua Homann on 12/9/16.
//  Copyright © 2016 Josh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button: RadialMenuButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        button.setMenu(images: [#imageLiteral(resourceName: "m1"), #imageLiteral(resourceName: "m2"),#imageLiteral(resourceName: "m3"),#imageLiteral(resourceName: "m4"),#imageLiteral(resourceName: "m5"),#imageLiteral(resourceName: "m6")])
    }
}

