//
//  ProfileViewController.swift
//  WhoWorks
//
//  Created by Медведь Святослав on 19.02.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit
import SWRevealViewController

class ProfileViewController: UIViewController {
    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    
    var currentUser: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        initRevealVCLogic()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEditProfile" {
            let editProfileVC = segue.destination as! EditProfileViewController
            editProfileVC.currentUser = currentUser
        }
    }
    
    private func initRevealVCLogic() {
        if let revealVC = revealViewController() {
            menuBarButton.target = revealVC
            menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
    }
}
