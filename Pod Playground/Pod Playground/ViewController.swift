//
//  ViewController.swift
//  Pod Playground
//
//  Created by Joshua Homann on 1/20/17.
//  Copyright © 2017 none. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        heightConstraint.constant = -500
        widthConstraint.constant = -400
        UIView.animate(withDuration: 5) {
            self.view.layoutIfNeeded()
        }
    }


}

