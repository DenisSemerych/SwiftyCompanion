//
//  AlertPresenter.swift
//  SwiftyCompanion
//
//  Created by Denis SEMERYCH on 6/28/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import UIKit


class AlertPresenter {
    
    var delegate: UIViewController?
    static var shared = AlertPresenter()
    
    func presentAlert(withTitle title: String) {
        let alert = UIAlertController(title: "Error", message: title, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        let action = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(action)
        delegate?.present(alert, animated: true)
    }
    
    private init() {}
}
