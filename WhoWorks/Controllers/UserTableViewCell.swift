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

    override func awakeFromNib() {
        super.awakeFromNib()
        statusCircle.layer.cornerRadius = 7.5
    }
}
