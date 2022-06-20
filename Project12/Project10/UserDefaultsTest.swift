//
//  UserDefaultsTest.swift
//  Project10
//
//  Created by Burak AKCAN on 19.06.2022.
//

import UIKit

class UserDefaultsTest: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //UserDefault bize küçük verileri saklayıp okumamızı sağlar
        let defaults = UserDefaults.standard
        defaults.set(25, forKey: "Age")
        defaults.set(false, forKey: "toDo")
        defaults.set(CGFloat.pi,forKey: "Pi")
        defaults.set(Date(),forKey: "date")
        let list = ["Ali","veli"]
        defaults.set(list,forKey: "students")
        let dic = ["name":"Burak","age":28,"referee":true] as [String : Any]
        defaults.set(dic,forKey: "Skils")
    
        
        //Read
        
        let saveInt = defaults.integer(forKey: "Age")
        let boolSave = defaults.bool(forKey: "toDo")
        let saveArray = defaults.object(forKey: "students") as? [String] ?? [String]()
        let saveDic = defaults.object(forKey: "Skils") as? [String:Any] ?? [String:Any]()
    }
    


}
