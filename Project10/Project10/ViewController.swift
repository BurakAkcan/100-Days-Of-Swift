//
//  ViewController.swift
//  Project10
//
//  Created by Burak AKCAN on 13.06.2022.
//

import UIKit

class ViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    var people = [Person]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPhoto))
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Şuan cell geel bir collectionViewCell bunu custom yaptığımız Person cell e bağlamak için type casting yaparız
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else{
            fatalError("Unable to deque  PersonCell")
        }
        let person = people[indexPath.item] //collectionView da item vardır row değil
        cell.nameLabel.text = person.name
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.image.image = UIImage(contentsOfFile: path.path)
        cell.image.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor //Gri tonlamalı renklerde kullanışlıdır
        cell.image.layer.borderWidth = 2
        cell.image.layer.cornerRadius = 4
        cell.layer.cornerRadius = 7
        return cell
    }
//Collectionları yan yana dizmek için kullandığımız kod bloğu
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding : CGFloat = 50
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]
        let ac = UIAlertController(title: "Rename Person", message:nil , preferredStyle:.alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self,weak ac] _ in
            guard let newName = ac?.textFields?[0].text else{return}
            person.name = newName
            self?.collectionView.reloadData()
        }))
        ac.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.default, handler: { [weak self] _ in
            self?.delete(index:indexPath.item)
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        present(ac, animated: true)
        
    }
   @objc func delete(index:Int){
       people.remove(at: index)
       collectionView.reloadData()
    }
    


}

extension ViewController {
    
     
    
    @objc func addPhoto(isCamera:Bool){
        let picker = UIImagePickerController()
        //Eklenen resim üerinde kullanıcı editleme yapsın mı?
        if isCamera {
            picker.sourceType = .camera
        }else{
            picker.sourceType = .photoLibrary
        }
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true)
      }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return } //Resim kesin var mı ?
        //Burada resmi aldık ve bir unique key dosyası oluşturduk
        //Daha sonra resmi jpeg formatına dönüştürüp jpeg diske uuidString ile yazdık
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        if let jpegData = image.jpegData(compressionQuality: 0.8){
            try? jpegData.write(to: imagePath)
        }
        
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        collectionView.reloadData()
        
        //Seçim işlemi tamamlandıktan sonra pencere kapatılsın
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
}

