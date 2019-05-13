//
//  UserInfoViewController.swift
//  SwiftyCompanion
//
//  Created by Denis SEMERYCH on 5/12/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import UIKit
import GTProgressBar
import DDSpiderChart

class UserInfoViewController: UIViewController {

    private var userData: UserData?
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var wallet: UILabel!
    @IBOutlet weak var evaluationPoints: UILabel!
    @IBOutlet weak var curcus: UILabel!
    @IBOutlet weak var grade: UILabel!
    @IBOutlet weak var campus: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var avalibleLocation: UILabel!
    @IBOutlet weak var levelBar: GTProgressBar!
    @IBOutlet weak var skillsChart: DDSpiderChartView!
    @IBOutlet weak var projectCarousel: UICollectionView!
    @IBOutlet weak var subProjectTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//Progress Bar methods
extension UserInfoViewController {
    
}

//Skills chart methods
extension UserInfoViewController {
    
}

//Project carousel methods
extension UserInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

//SubProjectTableView methods
extension UserInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}


