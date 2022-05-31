//
//  ViewController.swift
//  Project1 Use TableView
//
//  Created by Burak AKCAN on 21.05.2022.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: #selector(share))
        
        navigationController?.navigationBar.prefersLargeTitles = true
//Bu navigationbar title largeTitle özelliğini buradan da yapabiliriz main üzerinden navigation bara tıklayıp preferLargeTitle diyipte yapabiliriz
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl"){
                pictures.append(item)
            }
        }
        print(pictures)
        pictures.sort() //Listeyi sıraladık
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//didSelect seçilen indextki eleman için detay sayfasına gidecek
//stroyboard?.instantiate detay sayfasında storyboard kimliği oluşturmuştuk o kimlikle gideceğiz
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
//Detay sayfasından bir nesne oluşturduk vc adında ve onun propertysine isimleri liste olarak atadık
            vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func share(){
        
        
        let vt = UIActivityViewController(activityItems: ["Paylaşmak istediğine emin misin ?"], applicationActivities: [])
        vt.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vt, animated: true)
    }

        
}

