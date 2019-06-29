//
//  CollectionViewCell.swift
//  SwiftyCompanion
//
//  Created by Denis SEMERYCH on 6/26/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var subProjectsIcon: UIImageView!
    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var projectStatus: UILabel!
    @IBOutlet weak var projectMark: UILabel!
    @IBOutlet weak var markView: UIStackView!
}
