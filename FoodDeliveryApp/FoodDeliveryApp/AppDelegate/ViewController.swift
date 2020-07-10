//
//  ViewController.swift
//  FoodDeliveryApp
//
//  Created by Charlie on 8/7/20.
//  Copyright © 2020 C. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = HomeRouter.createModule()
        self.navigationController?.pushViewController(vc, animated: false)
    }


}

