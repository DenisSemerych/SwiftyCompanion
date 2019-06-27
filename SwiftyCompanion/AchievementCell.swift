//
//  AchievementCell.swift
//  SwiftyCompanion
//
//  Created by Denis SEMERYCH on 6/27/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import UIKit

class AchievementCell: UITableViewCell, UIWebViewDelegate {

    @IBOutlet weak var webViewPresenter: UIView!
    private var webView: UIWebView?
    @IBOutlet weak var achievementName: UILabel!
    @IBOutlet weak var achievementDescription: UILabel!
    var imageStringURL: String? {
        didSet {
            setUpWebView()
            getRequest()
        }
    }
    
    private var request: URLRequest? {
        didSet {
            if let request = request {webView?.loadRequest(request)}
        }
    }
    
    private func getRequest() {
        request = IntraAPIController.shared.giveRequestForSVGDownload(from: imageStringURL)
    }
    
    private func setUpWebView() {
        if let currentWebView = webView {
            currentWebView.removeFromSuperview()
            webView = nil
        }
        webView = UIWebView(frame: webViewPresenter.bounds)
        webView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView?.delegate = self
        webView?.isOpaque = false
        webViewPresenter.addSubview(webView!)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
