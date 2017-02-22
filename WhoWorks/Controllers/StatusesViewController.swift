//
//  StatusesViewController.swift
//  WhoWorks
//
//  Created by Медведь Святослав on 22.02.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit

class StatusesViewController: UIViewController {
    @IBOutlet weak var offlineStatusCircle: UIButton!
    @IBOutlet weak var doNotDisturbStatusCircle: UIButton!
    @IBOutlet weak var activeStatusCircle: UIButton!
    
    var currentStatusCode: UInt8 = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initStatuses(currentStatusCode)
    }
    
    @IBAction func chooseStatus(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func initStatuses(_ statusCode: UInt8) {
        for circleButton in [offlineStatusCircle, doNotDisturbStatusCircle, activeStatusCircle] {
            circleButton?.layer.cornerRadius = 20.0
            circleButton?.layer.borderWidth = 2.0
            circleButton?.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.0).cgColor
        }
        
        switch statusCode {
            case 0:
                offlineStatusCircle.layer.borderColor = UIColor.customLightGray().cgColor
            case 1:
                doNotDisturbStatusCircle.layer.borderColor = UIColor.customLightGray().cgColor
            default:
                activeStatusCircle.layer.borderColor = UIColor.customLightGray().cgColor
        }
    }
}
