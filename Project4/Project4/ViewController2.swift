//
//  ViewController2.swift
//  Project4
//
//  Created by Burak AKCAN on 23.05.2022.
//

import UIKit
import WebKit

class ViewController2: UIViewController,WKNavigationDelegate {
    var webView : WKWebView!
    var progressView : UIProgressView!
    var websites = ["www.apple.com.tr","www.oppo.com.tr"]
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: webView, action: #selector(webView.reload))
        let back = UIBarButtonItem(title: "<--", style: UIBarButtonItem.Style.plain, target: webView, action: #selector(webView.goBack))
        let forward = UIBarButtonItem(title: "-->", style: UIBarButtonItem.Style.plain, target: webView, action: #selector(webView.goForward))
        
        navigationController?.isToolbarHidden = false
        
        progressView = UIProgressView(progressViewStyle: UIProgressView.Style.default)
        progressView.tintColor = UIColor.red
        progressView.sizeToFit()
        
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [progressButton,space,refresh,back,forward]
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: NSKeyValueObservingOptions.new, context: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: UIBarButtonItem.Style.plain, target: self, action: #selector(openTapped))
        let url = URL(string: "https://"+websites[0])!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true

    }
    @objc func openTapped(){
        let ac = UIAlertController(title: "Siteye Git", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: UIAlertAction.Style.default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action:UIAlertAction){
        guard let actionTitle = action.title else {return}
        guard let url = URL(string: "https://" + actionTitle) else {return}
        webView.load(URLRequest(url: url))
        
    }
    
    override  func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
   
    
    
    
    

   
}
