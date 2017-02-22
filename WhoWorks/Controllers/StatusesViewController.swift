//
//  StatusesViewController.swift
//  WhoWorks
//
//  Created by Медведь Святослав on 22.02.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit

protocol PopoverViewControllerDelegate {
    func updateCurrentUser(_ statusCode: UInt8, _ statusColor: UIColor)
}

class StatusesViewController: UIViewController {
    @IBOutlet weak var offlineStatusCircle: UIButton!
    @IBOutlet weak var doNotDisturbStatusCircle: UIButton!
    @IBOutlet weak var activeStatusCircle: UIButton!
    
    var currentStatusCode: UInt8 = 2
    var currentUserId: UInt16?
    var delegate: PopoverViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initStatuses(currentStatusCode)
    }
    
    @IBAction func chooseStatus(_ sender: UIButton) {
        let newStatusCode = buttonToStatusCode(sender)
        let newStatusColor = UIColor(cgColor: sender.layer.borderColor!)
        
        UserService.updateStatusCode([currentUserId as Any, newStatusCode])
        
        self.delegate?.updateCurrentUser(newStatusCode, newStatusColor)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    private func initStatuses(_ statusCode: UInt8) {
        let statusCircles = [offlineStatusCircle, doNotDisturbStatusCircle, activeStatusCircle]
        
        for circleButton in statusCircles {
            circleButton?.layer.cornerRadius = 20.0
            circleButton?.layer.borderWidth = 0.0
        }
        
        offlineStatusCircle.layer.borderColor = UIColor.customRed().cgColor
        doNotDisturbStatusCircle.layer.borderColor = UIColor.customYellow().cgColor
        activeStatusCircle.layer.borderColor = UIColor.customGreen().cgColor
        statusCircles[Int(statusCode)]?.layer.borderWidth = 2.0
    }
    
    private func buttonToStatusCode(_ button: UIButton) -> UInt8 {
        switch button {
            case offlineStatusCircle:
                return 0
            case doNotDisturbStatusCircle:
                return 1
            default:
                return 2
        }
    }
}
