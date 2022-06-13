//
//  Person.swift
//  Project10
//
//  Created by Burak AKCAN on 13.06.2022.
//

//NSObject ürettiğimi bir sınıf UIkit te ki bütün her şeyi içerir demektir(UITableView,UICollectionView vs..)
import UIKit

class Person: NSObject {
    var name:String
    var image:String
    
    init(name:String,image:String){
        self.name = name
        self.image = image
    }

}
