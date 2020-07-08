//
//  ViewController.swift
//  Test Shashank Pali
//
//  Created by Shank on 24/06/20.
//  Copyright © 2020 Shank. All rights reserved.
//

import UIKit

class IntroductionController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.barStyle = .default
    }

}

