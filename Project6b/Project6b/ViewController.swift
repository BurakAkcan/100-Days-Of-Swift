//
//  ViewController.swift
//  Project6b
//
//  Created by Burak AKCAN on 25.05.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = UIColor.red
        label1.text = "THESE"
        label1.sizeToFit()
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.text = "ARE"
        label2.backgroundColor = UIColor.cyan
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.text = "SOME"
        label3.backgroundColor = UIColor.yellow
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.text = "AWESOME"
        label4.backgroundColor = UIColor.green
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.text = "LABELS"
        label5.backgroundColor = UIColor.orange
        label5.sizeToFit()
        
//        var labels = [label1,label2,label3,label4,label5]
//
//        for i in labels {
//            view.addSubview(i)
//        }
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
        let viewsDictionary : [String:UILabel] = ["label1":label1,"label2":label2,"label3":label3,"label4":label4,"label5":label5]
        
        
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label1]|", options: [], metrics: nil, views: viewsDictionary))
  
//Yukarıda yaptığımız işlei tüm label lara for in  .key kullanarak yaptık
        
//View.addConstraints viewController view a bir ksıtlama ekler
//NSLAyoutConstraint.constraints bir auto Layout metodudur en öenmli parametresi ilki ve sonuncusudur
// H:|[label1]| yatay bir yerleşim tanımladığımız anlamına gelir ve laballer uçtan uca yatayda oturacaktır
//VFL Visual Format Language
        for label in viewsDictionary.keys {
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))

            
        }
//label1(==88) label1 in dikeyde yüksekliği sondaki -(>=10)-|  bottomla son label arasındaki  mesafe en 10 olmalı demek (|=> ekranın sonu demk)
//labelların yüksekliği değiştiğinde bunların hepsini tek tek değiştirmek yerine şunu yazabilirim
        let metrics = ["labelHeight":120]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]-(>=20)-|", options: [], metrics: metrics, views: viewsDictionary))//labllar arasındaki - space dir ve default olarak 10 gelir

//yatayda şöyle bir hata alırız kısıtlamalar aynı anda karşılanmıyor diyor işte burada karşımıza priority çıkar kısıtlama önceliği demek bu
//tüm kısıtlamalar otomatik olara 1000 değerini almıştır 1000 olan kesinlikle zorunlu ama biri 999 olsa onun üzerinden esneklik yapabilir

        //Hepsi mükemmel bir şekilde oturdu
    
    
    }


}

