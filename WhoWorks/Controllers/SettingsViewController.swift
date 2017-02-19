//
//  SettingsViewController.swift
//  WhoWorks
//
//  Created by Медведь Святослав on 19.02.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initRevealVCLogic()
    }
    
    @objc private func initRevealVCLogic() {
        if let revealVC = revealViewController() {
            menuBarButton.target = revealVC
            menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
    }
}
