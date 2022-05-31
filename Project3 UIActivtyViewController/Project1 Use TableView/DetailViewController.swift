//
//  DetailViewController.swift
//  Project1 Use TableView
//
//  Created by Burak AKCAN on 21.05.2022.
//

import UIKit

class DetailViewController: UIViewController {

//Eklediğimiz UIKit nesnesinin etkileşimdeolduğu kod bloğunda içi dolu nokta var tıkladığımızda hangi sayfa da ne ile bağlantılı gösterir

    @IBOutlet var imageView: UIImageView!
    
    var selectedImage:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
 //Resimle beraber resmin ismi gözükür
        title = selectedImage
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: #selector(shareTapped))
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }

        // Do any additional setup after loading the view.
    }
//Resmin tamamını göstermek istiyoruz barOnTap sayfa gözükünce gizlemek istiyorsak viewWillAppear kısmında aşağıdaki kodu çalıştırmalıyız
//Bir resim gösterirken kullanmamız lazım hiddeBarOnTap yoksa sayfadan çıktığımızda herhangi bir yere tıkladığımızda çalışmaz
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped(){
        
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else{
            print("resim bulunamadı")
            return
        }
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
        
    }
//Resmi eğer telefona indirme istiyorsak info dan photalibrary addition usage  description seçeneğini eklememiz gerekiyor
    

 
}
