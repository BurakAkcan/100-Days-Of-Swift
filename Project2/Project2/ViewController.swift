//
//  ViewController.swift
//  Project2
//
//  Created by Burak AKCAN on 21.05.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    
    @IBOutlet var button2: UIButton!
    
    
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score:Int = 0
    var correctAnswer:Int = 0
    var end:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia","france","germany","nigeria","italy","monaco","russia","ireland","uk"]
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: #selector(shareScore))
        
//Bayraklar tam gözükmediği için butonlara border atayacağız
        button1.layer.borderWidth = 2
        button2.layer.borderWidth = 2
        button3 .layer.borderWidth = 2
        
        button1.layer.borderColor = UIColor.yellow.cgColor
        button2.layer.borderColor = UIColor.yellow.cgColor

        button3.layer.borderColor = UIColor.yellow.cgColor
// UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0).cgColor kendi rengimizi bu şekilde belirleyebiliriz
        
        askQuestion()
        
    }
  // askQ metodumuz UIAlertAction nesnesi bekler biz  Default olarak nil değeri verdik
    func askQuestion(action:UIAlertAction! = nil){
        if end < 5 {
            countries.shuffle()//Listeyi karıştıracak ve 0. index farklı 1. index farklı olacak
            correctAnswer = Int.random(in: 0...2)
            button1.setImage(UIImage(named: countries[0]), for: .normal)
            button2.setImage(UIImage(named: countries[1]), for: .normal)
            button3.setImage(UIImage(named: countries[2]), for: .normal)
            
            title = countries[correctAnswer].uppercased()
            end += 1
        }else {
            let ac = UIAlertController(title: "Oyun bitti", message: "Genel Scorunuz: \(score)", preferredStyle: UIAlertController.Style.alert)
            ac.addAction(UIAlertAction(title: "Devam", style: UIAlertAction.Style.default, handler: askQuestion))
            present(ac, animated: true)
            end = 0
            score = 0
        }
    }
//Bütün butonları tek biraksiyona bağladık unutma!!!
//butonarın tag lerini değiştirmek lazım
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title:String
        
        if sender.tag == correctAnswer{
            title = "Correct"
            score += 1
        }else{
            title = "Wrong"
            score -= 1
        }
        let ac = UIAlertController(title: title, message: "Your Score is \(score)", preferredStyle: UIAlertController.Style.alert)
//handler devamında ne olcak bir closure yapısı bekler , oyunun devam etmesini istiyoruz
        ac.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: askQuestion))
        present(ac, animated: true)
    }
    @objc func shareScore(){
        let vc = UIActivityViewController(activityItems: ["Your Score is \(score)"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
        present(vc, animated: true)
    }
    

}

