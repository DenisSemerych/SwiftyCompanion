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
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var wallet: UILabel!
    @IBOutlet weak var evaluationPoints: UILabel!
    @IBOutlet weak var cursus: UIButton!
    @IBOutlet weak var grade: UILabel!
    @IBOutlet weak var campus: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var avalibleLocation: UILabel!
    @IBOutlet weak var levelBar: GTProgressBar!
    @IBOutlet weak var skillsChart: DDSpiderChartView!
    @IBOutlet weak var projectCarousel: UICollectionView!
    @IBOutlet weak var subProjectTable: UITableView!
    
    //presenting UIPicker when choosing cursus
    @IBAction func cursusChooseButtonPressed(_ sender: UIButton) {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.backgroundColor = .black
        view.addSubview(picker)
        picker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        picker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        picker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor(red: 83/255, green: 183/255, blue: 186, alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


//PickerView methods
extension UserInfoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
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


