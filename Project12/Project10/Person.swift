//
//  Person.swift
//  Project10
//
//  Created by Burak AKCAN on 13.06.2022.
//

//NSObject ürettiğimi bir sınıf UIkit te ki bütün her şeyi içerir demektir(UITableView,UICollectionView vs..)
import UIKit


//Eğer person class ından bir nesneyi UserDefault a kaydetmek istersek NSCoding sınıfını implement etmem gerek
//Eğer class yerine struct kullanmak istseydik o zaman NSCoding kullanamamıza gerek yoktu
//Öncelikle sınıfımız üzerinde NSCoding sınıfını devralmamız için sınıfımızın NSObject sınıfından türemiş olması gerekli.
//class Person: NSObject,NSCoding {
//
//
//    var name:String
//    var image:String
//
//    init(name:String,image:String){
//        self.name = name
//        self.image = image
//    }
//
//    func encode(with coder: NSCoder) {
//        //Writing
//        coder.encode(name, forKey: "name")
//        coder.encode(image,forKey: "image")
//    }
//
//    required init?(coder: NSCoder) {
//        //Reading
//        name = coder.decodeObject(forKey: "name") as? String ?? ""
//        image = coder.decodeObject(forKey: "image") as? String ?? ""
//    }
//
//}
//Eğerjson olarak veriyi UserDefault a kaydedip okuyacaksak NSCoding sınıfından kalıtmama gerek yok!!!
class Person : NSObject,Codable{
    var name:String
    var image:String
    init(name:String,image:String){
        self.name = name
        self.image = image
    }
}


//Not: Kendi yazdığımız bir sınıfı örneğin User adlı sınıfı ekleyip kaydetmeye çalıştığımızda olay uygulama kapanması ile sonuçlanmaktadır. Kendi yazdığımız sınıfı cihaz üzerinde kalıcı olarak UserDefaults ile kaydetmek istediğimiz zaman NSCoding sınıfını sınıfımız üzerinde kullanmamız gerekli.


class User:NSObject,NSCoding{
   
    
    var nick:String
    var mail:String
    init(nick:String,mail:String){
        self.nick = nick
        self.mail = mail
    }
    //required init kullanırız
    required convenience init?(coder: NSCoder) {
        let dNick = coder.decodeObject(forKey: "nick") as! String
        let dMail = coder.decodeObject(forKey: "mail") as! String
        self.init(nick: dNick, mail: dMail)
    }
    func encode(with coder: NSCoder) {
        coder.encode(nick,forKey: "nick")
        coder.encode(mail, forKey: "mail")
    }
    
}

//Sınıfımız içine encode ve decode metotlarını yazıyoruz böylelikle sınıfımız arşivlenmeye hazır
//Verileri eklemede NSKeyedArchiver yaparı
//Verileri okumada ise NSKeyedUnarchiver kullanırız
let obj = User(nick: "brk", mail: "brk@gmail.com")
let userData = NSKeyedArchiver.archivedData(withRootObject: obj)













//class User1 {
//    var name:String
//    var age:Int
//    init(name:String,age:Int){
//        self.name = name
//        self.age = age
//    }
//
//    convenience init() {
//        self.init(name: "no name", age: 0)
//    }
//}
//
//class Company : User1 {
//    var company:String
//     init(company:String,name:String,age:Int) {
//        self.company = company
//        super.init(name: name, age: age)
//    }
//}
