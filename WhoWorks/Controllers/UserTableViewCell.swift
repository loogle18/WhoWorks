//
//  UserTableViewCell.swift
//  WhoWorks
//
//  Created by Медведь Святослав on 09.02.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var statusCircle: UILabel!
    @IBOutlet weak var loginName: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    var circleColor: UIColor!

    override func awakeFromNib() {
        super.awakeFromNib()
        statusCircle.layer.cornerRadius = 7.5
        avatarImageView.layer.cornerRadius = 20.0
        changeSelectedColor()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        statusCircle.backgroundColor = circleColor
    }
    
    @objc private func changeSelectedColor() {
        let cellBGView = UIView()
        cellBGView.backgroundColor = UIColor(red: 28/255, green: 25/255, blue: 33/255, alpha: 1)
        self.selectedBackgroundView = cellBGView
    }
}
