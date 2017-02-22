//
//  CurrentUserMenuViewController.swift
//  WhoWorks
//
//  Created by Медведь Святослав on 15.02.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit
import SWRevealViewController

class CurrentUserMenuViewController: UIViewController {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userLogin: UILabel!
    @IBOutlet weak var statusCircle: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var teamListButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    var currentUser: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        avatarImageView.layer.cornerRadius = 80.0
        statusCircle.layer.cornerRadius = 7.5
        avatarImageView.image = currentUser?.avatar
        statusCircle.layer.backgroundColor = currentUser?.statusColor.cgColor
        userEmail.text = currentUser?.email
        userLogin.text = currentUser?.login
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initTogglerForButtons()
    }
    
    @IBAction func logout(_ sender: UIButton) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let rootNavVC = mainStoryBoard.instantiateViewController(withIdentifier: "RootNavView")
        self.show(rootNavVC, sender: self)
    }

    @IBAction func menuButtonHandler(_ sender: UIButton) {
        if let revealVC = revealViewController() {
            if sender == buttonToCurrentVC(revealVC.frontViewController) {
                revealVC.revealToggle(animated: true)
            } else {
                addProperSegues(sender)
            }
        }
    }
    
    private func initTogglerForButtons() {
        if let revealVC = revealViewController() {
            removeActionTargetsAndStyles(revealVC, buttons: profileButton, settingsButton, teamListButton)
            let buttonOfCurrentVC = buttonToCurrentVC(revealVC.frontViewController)
            buttonOfCurrentVC.backgroundColor = UIColor.customRed()
        }
    }
    
    private func buttonToCurrentVC(_ vc: UIViewController) -> UIButton {
        switch vc {
            case is ProfileViewController:
                return profileButton
            case is SettingsViewController:
                return settingsButton
            default:
                return teamListButton
        }
    }
    
    private func addProperSegues(_ button: UIButton) {
        switch button {
            case profileButton:
                performSegue(withIdentifier: "showProfileFromMenu", sender: button)
            case settingsButton:
                performSegue(withIdentifier: "showSettingsFromMenu", sender: button)
            default:
                performSegue(withIdentifier: "showUsersFromMenu", sender: button)
        }
    }
    
    private func removeActionTargetsAndStyles(_ selector: UIViewController, buttons: UIButton...) {
        for button in buttons {
            button.removeTarget(selector, action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            button.backgroundColor = UIColor.customBlack()
            button.setTitleColor(UIColor.white, for: .normal)
        }
    }
}
