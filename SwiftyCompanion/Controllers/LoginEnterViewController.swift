//
//  ViewController.swift
//  SwiftyCompanion
//
//  Created by Denis SEMERYCH on 5/10/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import UIKit

class LoginEnterViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loginSearchField: UITextField!
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        IntraAPIController.shared.requestUserInfo(login: loginSearchField.text!)
        loginSearchField.resignFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white
        changePlaceholderFont()
        loginSearchField.layer.borderWidth = 1
        loginSearchField.layer.borderColor  = UIColor(red: 85/255, green: 183/255, blue: 186/255, alpha: 1).cgColor
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        self.navigationController?.navigationBar.isHidden = true
        IntraAPIController.shared.delegate = self
        AlertPresenter.shared.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLoginInfo" {
            let destVC = segue.destination as! UserInfoViewController
            destVC.userData = sender as? UserData
        }
    }
}



//Changing TextView
extension LoginEnterViewController: UITextFieldDelegate {
    
    //resigning first responder when pressing return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginSearchField.resignFirstResponder()
        return true
    }
    
    //Resigning first responder on touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        loginSearchField.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
        let font = UIFont.init(name: "Baskerville-Bold", size: CGFloat.init(18))
        textField.font = font
        textField.textColor = .white
    }
    
    //making custom font for textView
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        changePlaceholderFont()
    }
    
    //alowing to enter only letters in textfield
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.letters
        let enteredCharacters = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: enteredCharacters)
    }
    
    //changing placeholder font
    private func changePlaceholderFont() {
        let atributes = [
            NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.5),
            NSAttributedString.Key.font : UIFont(name: "Baskerville", size: 15)!
        ]
        loginSearchField.attributedPlaceholder = NSAttributedString(string: "Enter Intra 42 login", attributes: atributes)
    }
}

extension LoginEnterViewController: IntraAPIDelegate {
    func processRequestResult(result: RequestResult, with data: Data?) {
        switch result {
        case .success:
            guard let userData = ItemFactory.shared.createUser(from: data!) else {AlertPresenter.shared.presentAlert(withTitle: "No such user in Intra42"); return}
            performSegue(withIdentifier: "goToLoginInfo", sender: userData)
        case .requestFailure:
            AlertPresenter.shared.presentAlert(withTitle: result.rawValue)
        }
    }
    
}
