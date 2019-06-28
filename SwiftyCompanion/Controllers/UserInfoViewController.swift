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
    private var cursusToShow: Cursus? {
        didSet {
            guard let cursus = cursusToShow else {return}
            projectCarousel.reloadData()
            grade.text = "Grade: \(cursus.cursusUserGrade)"
            self.cursus.setTitle("Cursus \(cursus.name)", for: .normal)
            setUpProgressBar()
            setUpSkillChart()
            isShowingSubprojects = false
        }
    }
    private var pickerPresenterView: UIView?
    private var pickerView: UIPickerView?
    private var submitButton: UIButton?
    private var cancelButton: UIButton?
    private var isShowingSubprojects = false {
        didSet {
            subProjectTable.reloadData()
        }
    }
    private var projectIndex = 0
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
    @IBOutlet weak var levelLable: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let dataToShow = userData else {return}
        mainView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        projectCarousel.delegate = self
        projectCarousel.dataSource = self
        subProjectTable.delegate = self
        subProjectTable.dataSource = self
        projectCarousel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        if let imageURL = dataToShow.imageURL {
            IntraAPIController.shared.downloadImageData(from: imageURL)
        }
        navigationItem.title = userData?.name
        wallet.text = "\(wallet.text!): \(dataToShow.wallet)"
        evaluationPoints.text = "Evaluation Points: \(dataToShow.evaluationPoints)"
        campus.text = "Campus: \(dataToShow.campus)"
        phoneNumber.text = "\(dataToShow.phoneNumber)"
        email.text = "\(dataToShow.email)"
        if let location = userData?.location {
            avalibleLocation.text = "Avaliable \n\(location)"
        } else {
            avalibleLocation.text = "Unavaliable"
        }
        cursusToShow = dataToShow.cursuses.first
    }
    
    override func viewWillAppear(_ animated: Bool) {
         IntraAPIController.shared.delegate = self
         AlertPresenter.shared.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


//PickerView methods
extension UserInfoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    //presenting UIPicker when choosing cursus
    @IBAction func cursusChooseButtonPressed(_ sender: UIButton) {
        guard pickerView == nil else {return}
        presentPickerView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        removePickerPresenter()
    }
    
    @objc func chooseCursus() {
        guard let picker = pickerView, let data = userData else {return}
        cursusToShow = data.cursuses[picker.selectedRow(inComponent: 0)]
        removePickerPresenter()
    }
    
    @objc func cancelChoosing() {
        removePickerPresenter()
    }
    
    private func removePickerPresenter() {
        guard let pickerPresenter = pickerPresenterView, let picker = pickerView, let button = submitButton else {return}
        pickerPresenter.removeFromSuperview()
        picker.removeFromSuperview()
        button.removeFromSuperview()
        pickerPresenterView = nil
        pickerView = nil
        submitButton = nil
    }
    
    //presenting PickerPresenterView and PickerView
    private func presentPickerView() {
        pickerPresenterView = UIView()
        view.addSubview(pickerPresenterView!)
        pickerView = UIPickerView()
        pickerPresenterView!.addSubview(pickerView!)
        pickerView?.delegate = self
        pickerView?.dataSource = self
        pickerView?.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.8)
        createButtons()
        setConstrains()
    }
    
    
    //Creating buttons for submission and cancel
    private func createButtons() {
        submitButton = UIButton()
        cancelButton = UIButton()
        cancelButton?.setTitle("Cancel", for: .normal)
        submitButton?.setTitle("Submit", for: .normal)
        cancelButton?.setTitleColor(.white, for: .normal)
        submitButton?.setTitleColor(.white, for: .normal)
        cancelButton?.addTarget(self, action: #selector(cancelChoosing), for: .touchUpInside)
        submitButton?.addTarget(self, action: #selector(chooseCursus), for: .touchUpInside)
        submitButton?.backgroundColor = UIColor(red: 115/255, green: 182/255, blue: 102/255, alpha: 0.8)
        cancelButton?.backgroundColor = UIColor(red: 202/255, green: 106/255, blue: 113/255, alpha: 0.8)
        pickerPresenterView?.addSubview(submitButton!)
        pickerPresenterView?.addSubview(cancelButton!)
    }
    
    //setting constrains for PickerPresenter, PickerView, Buttons
    private func setConstrains() {
        pickerPresenterView?.translatesAutoresizingMaskIntoConstraints = false
        pickerPresenterView?.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pickerPresenterView?.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pickerPresenterView?.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        pickerView?.translatesAutoresizingMaskIntoConstraints = false
        pickerView?.leadingAnchor.constraint(equalTo: pickerPresenterView!.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pickerView?.trailingAnchor.constraint(equalTo: pickerPresenterView!.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pickerView?.bottomAnchor.constraint(equalTo: pickerPresenterView!.safeAreaLayoutGuide.bottomAnchor).isActive = true
        cancelButton?.translatesAutoresizingMaskIntoConstraints = false
        cancelButton?.leadingAnchor.constraint(equalTo: pickerPresenterView!.safeAreaLayoutGuide.leadingAnchor).isActive = true
        cancelButton?.topAnchor.constraint(equalTo: pickerPresenterView!.safeAreaLayoutGuide.topAnchor).isActive = true
        cancelButton?.bottomAnchor.constraint(equalTo: pickerView!.safeAreaLayoutGuide.topAnchor).isActive = true
        submitButton?.translatesAutoresizingMaskIntoConstraints = false
        submitButton?.trailingAnchor.constraint(equalTo: pickerPresenterView!.safeAreaLayoutGuide.trailingAnchor).isActive = true
        submitButton?.topAnchor.constraint(equalTo: pickerPresenterView!.safeAreaLayoutGuide.topAnchor).isActive = true
        submitButton?.bottomAnchor.constraint(equalTo: pickerView!.safeAreaLayoutGuide.topAnchor).isActive = true
        submitButton?.leadingAnchor.constraint(equalTo: cancelButton!.safeAreaLayoutGuide.trailingAnchor).isActive = true 
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userData?.cursuses.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = userData?.cursuses[row].name ?? ""
        return NSAttributedString(string: title, attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: 15.0)!,NSAttributedString.Key.foregroundColor:UIColor(red: 85/255, green: 183/255, blue: 186/255, alpha: 1)])
    }
}

//Progress Bar methods
extension UserInfoViewController {
    private func setUpProgressBar() {
        guard let cursus = cursusToShow else {return}
        levelBar.orientation = .horizontal
        levelBar.direction = .clockwise
        let progress = round(100 * (cursus.cursusUserLevel - Double(Int(cursus.cursusUserLevel)))) / 100
        levelBar.animateTo(progress: CGFloat(progress))
        levelBar.barBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        levelBar.barFillColor = UIColor(red: 85/255, green: 183/255, blue: 186/255, alpha: 0.7)
        levelLable.text = "level \(Int(cursus.cursusUserLevel))-\(Int(progress * 100))%"
    }
}

//Skills chart methods
extension UserInfoViewController {
    private func setUpSkillChart() {
        guard  let cursus = cursusToShow else {return}
        skillsChart.axes = cursus.skills.map({attributedAxis(lable: $0.name.replacingOccurrences(of: " ", with: " \n"))})
        skillsChart.addDataSet(values: cursus.skills.map({Float($0.level / 15)}), color: UIColor(red: 85/255, green: 183/255, blue: 186/255, alpha: 1))
        skillsChart.circleCount = 10
        skillsChart.circleGap = 12
        skillsChart.color = .white
    }
    
    private func attributedAxis(lable: String) -> NSAttributedString {
        return NSAttributedString(string: lable, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
}

//Project carousel methods
extension UserInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let cursus = cursusToShow else {return 0}
        return cursus.allProjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cursus = cursusToShow else {return UICollectionViewCell()}
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "projectCell", for: indexPath) as! CollectionViewCell
        let project = cursus.allProjects[indexPath.row]
        cell.projectName.text = project.name
        cell.projectStatus.text = project.validated.rawValue
        cell.projectMark.text = "\(project.finalMark)"
        switch project.validated {
        case .failed:
            cell.backgroundColor = UIColor(red: 202/255, green: 106/255, blue: 113/255, alpha: 1)
            cell.markView.isHidden = false
        case .waiting:
            cell.backgroundColor = UIColor(red: 85/255, green: 183/255, blue: 186/255, alpha: 1)
            cell.markView.isHidden = true
        case .valid:
            cell.backgroundColor = UIColor(red: 115/255, green: 182/255, blue: 102/255, alpha: 1)
            cell.markView.isHidden = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cursus = cursusToShow else {return}
        if cursus.allProjects[indexPath.row].subProjects.count > 0 {
            projectIndex = indexPath.row
            isShowingSubprojects = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        isShowingSubprojects = false
    }
}

//SubProjectTableView methods
extension UserInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let cursus = cursusToShow, let data = userData {
           return isShowingSubprojects ? cursus.allProjects[projectIndex].subProjects.count : data.achievements.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cursus = cursusToShow, let data = userData else {return UITableViewCell()}
        if isShowingSubprojects {
            let cell = tableView.dequeueReusableCell(withIdentifier: "subprojectCell") as! SubprojectCell
            let project = cursus.allProjects[projectIndex].subProjects[indexPath.row]
            cell.projectName.text = project.name
            cell.projectMark.text = "\(project.finalMark)"
            let color: UIColor
            switch project.validated {
            case .failed:
                color =  UIColor(red: 202/255, green: 106/255, blue: 113/255, alpha: 1)
            case .valid:
                color = UIColor(red: 115/255, green: 182/255, blue: 102/255, alpha: 1)
            case .waiting:
                color = UIColor(red: 85/255, green: 183/255, blue: 186/255, alpha: 1)
            }
            cell.backgroundColor = color
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "achievementCell") as! AchievementCell
            cell.achievementDescription.text = data.achievements[indexPath.row].description
            cell.achievementName.text = data.achievements[indexPath.row].name
            cell.imageStringURL = data.achievements[indexPath.row].stringURL
            return cell
        }
    }
}

extension UserInfoViewController: IntraAPIDelegate {
    
    func processRequestResult(result: RequestResult, with data: Data?) {
        guard  let imageData = data else {return}
        switch result {
        case .success:
            self.profileImage.image = UIImage(data: imageData)
        case .requestFailure:
            AlertPresenter.shared.presentAlert(withTitle: result.rawValue)
        }
    }
}


