//
//  ViewController.swift
//  SwiftyCompanion
//
//  Created by Denis SEMERYCH on 5/10/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import UIKit

class LoginEnterViewController: UIViewController {

    private var intraAPIConroller = IntraAPIController()
    
    @IBOutlet weak var loginSearchField: UITextField!
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        intraAPIConroller.requestUserInfo(login: loginSearchField.text!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        intraAPIConroller.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        changePlaceholderFont()
        loginSearchField.layer.borderWidth = 1
        loginSearchField.layer.borderColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = false
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
        textField.textColor = .black
    }
    
    //making custom font for textView
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
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
            NSAttributedStringKey.foregroundColor: UIColor.gray.withAlphaComponent(0.5),
            NSAttributedStringKey.font : UIFont(name: "Baskerville-Italic", size: 18)!
        ]
        loginSearchField.attributedPlaceholder = NSAttributedString(string: "Enter Intra 42 login", attributes: atributes)
    }
    
    
    
}

extension LoginEnterViewController: IntraAPIDelegate {
    func processRequestResult(result: RequestResult, with data: Data?) {
        switch result {
        case .success:
            let userData = UserData(form: data!)
            performSegue(withIdentifier: "goToLoginInfo", sender: self)
        case .noSuchLogin:
            print("Bad login")
        case .requestFailure:
            print("Fail to send")
        }
    }
}
