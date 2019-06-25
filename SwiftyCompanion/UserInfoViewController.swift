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

    var userData: UserData?
    private var cursusToShow: Cursus?
    var pickerView: UIPickerView?
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
        guard pickerView == nil else {return}
        pickerView = UIPickerView()
        pickerView!.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pickerView!)
        pickerView!.delegate = self
        pickerView!.dataSource = self
        pickerView!.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
        pickerView!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pickerView!.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pickerView!.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let dataToShow = userData else {return}
        setProfileImage(from: dataToShow.image)
        wallet.text = "\(wallet.text!): \(dataToShow.wallet)"
        evaluationPoints.text = "\(evaluationPoints.text!): \(dataToShow.evaluationPoints)"
        campus.text = "\(campus.text!): \(dataToShow.campus)"
        phoneNumber.text = "\(dataToShow.phoneNumber)"
        email.text = "\(dataToShow.email)"
        if let location = userData?.location {
            avalibleLocation.text = "Avaliable \n\(location)"
        } else {
            avalibleLocation.text = "Unavaliable"
        }
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
        return userData?.cursuses.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = userData?.cursuses[row].name ?? ""
        return NSAttributedString(string: title, attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: 15.0)!,NSAttributedString.Key.foregroundColor:UIColor.blue])
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

extension UserInfoViewController {
    func setProfileImage(from url: URL?) {
        guard let imageUrl = url else {return}
        URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
            guard let data = data, error == nil else {return}
            DispatchQueue.main.async {[unowned self] in
                self.profileImage.image = UIImage(data: data)
            }
        }.resume()
    }
}


