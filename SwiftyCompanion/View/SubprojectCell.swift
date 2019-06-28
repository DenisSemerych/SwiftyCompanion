//
//  SubprojectCell.swift
//  SwiftyCompanion
//
//  Created by Denis SEMERYCH on 6/27/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import UIKit

class SubprojectCell: UITableViewCell {

    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var projectMark: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
