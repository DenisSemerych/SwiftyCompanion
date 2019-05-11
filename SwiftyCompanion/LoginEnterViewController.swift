//
//  ViewController.swift
//  SwiftyCompanion
//
//  Created by Denis SEMERYCH on 5/10/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import UIKit

class LoginEnterViewController: UIViewController {

    
    private let apiDelegate: ApiDelegate
    @IBOutlet weak var loginSearchField: UITextField!
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        let login = loginSearchField.text
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        changePlaceholderFont()
        loginSearchField.layer.borderWidth = 1
        loginSearchField.layer.borderColor = UIColor.black.cgColor
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
    
    //changing placeholder font
    private func changePlaceholderFont() {
        let atributes = [
            NSAttributedStringKey.foregroundColor: UIColor.gray.withAlphaComponent(0.5),
            NSAttributedStringKey.font : UIFont(name: "Baskerville-Italic", size: 18)!
        ]
        loginSearchField.attributedPlaceholder = NSAttributedString(string: "Enter Intra 42 login", attributes: atributes)
    }
}
