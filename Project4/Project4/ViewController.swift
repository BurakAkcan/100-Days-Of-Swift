//
//  ViewController.swift
//  Project4
//
//  Created by Burak AKCAN on 22.05.2022.
//

import UIKit
import WebKit //Web sayfalarını açmak için kullndığımız kütüphane

class ViewController: UIViewController, WKNavigationDelegate {
    var webView : WKWebView!
    var progressview : UIProgressView!
    var webSites = ["www.apple.com.tr","www.oppo.com.tr"]

//Delegate diğerinin yerine hareket eden , soruları yanıtlayan ve olaylara kendi yanıt veren bir aracıdır.
//herhangi bir web sayfasında gezinme olduğunda ,bana söyle (navigationDelegate)
    override func loadView() {
        webView = WKWebView()
//Herhangi bir web sayfasına gitme durumunda viewController a haber vermiş olduk navigationDelegate sayesinde
        webView.navigationDelegate = self
        view = webView
    }

// KVO Key Value Observing , x propertysinde herhangi bir değişiklik oldu bana bildir
    override func viewDidLoad() {
        super.viewDidLoad()
 //Aşağıda boş bir alan oluşturmamızı sağladı spacer .flexible diyerek
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace  , target: nil, action: nil)
        
        let refresh = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: webView, action:#selector(webView.reload))
        

        navigationController?.isToolbarHidden = false
        
        
        progressview = UIProgressView(progressViewStyle: .default)
//sizeToFit progresView ın içeriğinin tam oturmasını sağlar
        progressview.sizeToFit()
        progressview.tintColor = UIColor.orange
        
//Progresview bir butonmuş gibi UIBarButtonItem custom yaparak toolbarItems listesiniin içine yazdık
        let progresButton = UIBarButtonItem(customView: progressview)
        
        //Toolbar UIBarButtonItem bekleyen bir liste
                
                toolbarItems = [progresButton,spacer,refresh]
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: NSKeyValueObservingOptions.new, context: nil)
        
        
//        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: NSKeyValueObservingOptions.new, context: nil)
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        let url = URL(string: "https://" + webSites[0])!
        webView.load(URLRequest(url: url))
        //allowBackForwardNavigationGestures web sayfasında ileri geri gezinmemizi sağlayan metottur.
        webView.allowsBackForwardNavigationGestures = true
    }
    
    @objc func openTapped(){
//Bu sefer actionSheet yaptık
        let ac = UIAlertController(title: "Open Page", message: nil, preferredStyle: .actionSheet)
        
        for web in webSites {
            ac.addAction(UIAlertAction(title: web, style: .default, handler: openPage))
        }
        
        //Bir tane ha action ekliyoruz
//        ac.addAction(UIAlertAction(title: "oppo.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action:UIAlertAction) {
//url nil dönebilir anı şekilde action.title da o yüzden bu iki parametre için guard let kullandık ve forceUnWrap ı kaldırdık
        guard  let acitionTitle = action.title else{
            return
        }
        guard let url = URL(string: "https://" + acitionTitle) else{
            return
        }
        webView.load(URLRequest(url: url))
       
    }
//Sayfa gelince vievcontroller title açılan sayfa ismi olsun diye bunu yaptık
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressview.progress = Float(webView.estimatedProgress)
        }
    }
//Sitenin doğru yüklenip yüklenmediğini kontrol eder ,bir forma tıkladığımızda tetiklenip tetiklenmediğini görürsünüz
//Sayfa yüklenmeli miyüklenmemeli mi buna descionHandler ile karar veriyoruz
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for site in webSites {
                if host.contains(site){
                    decisionHandler(WKNavigationActionPolicy.allow)
                    return
                }
            }
            
        }
       
        decisionHandler(.cancel)
        let ac = UIAlertController(title: "Opps", message: "Bad request", preferredStyle: UIAlertController.Style.alert)
        ac.addAction(UIAlertAction(title: "404 Not Found", style: UIAlertAction.Style.default, handler: nil))
        present(ac, animated: true)
        
    }

}
