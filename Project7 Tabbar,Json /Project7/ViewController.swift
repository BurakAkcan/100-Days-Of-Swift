//
//  ViewController.swift
//  Project7
//
//  Created by Burak AKCAN on 30.05.2022.
//


import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var filteredItems = [Petition]()
    var mainItms = [Petition]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(credit))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: #selector(wordFilter))
       // navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(organize))

        let urlString : String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        }else {
            urlString = "https://hackingwithswift.com/samples/petitions-2.json"
        }

      

        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
               print(data)
               return
            }
        }

      showError()
    }

    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
            mainItms = petitions
        }
    }
    
    func showError(){
        let ac = UIAlertController(title: "Loading Error", message: "Something went wrong", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
        present(ac, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func submit(_ text:String){
        filteredItems.removeAll()
        for petition in petitions {
            if petition.body.lowercased().contains(text.lowercased()){
                filteredItems.append(petition)
            }
            if petition.title.lowercased().contains(text.lowercased()){
                filteredItems.append(petition)
            }
        }
        if filteredItems.isEmpty {return}
        petitions = filteredItems
        tableView.reloadData()
        
    }
    func resetButton(){
        petitions = mainItms
        tableView.reloadData()
    }
    func organizem(text:String){
        filteredItems.removeAll()
        for i in petitions {
            if i.title.lowercased().contains(text.lowercased()){
                filteredItems.append(i)
            }
        }
        if filteredItems.isEmpty {return}
        petitions = filteredItems
        tableView.reloadData()
        
    }

   
}

extension ViewController {
    @objc func credit(){
        let ac = UIAlertController(title: "Your data", message: "The data comes from White House", preferredStyle: UIAlertController.Style.alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    @objc func wordFilter(){
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Find", style: .default){_ in
            guard let text = ac.textFields?[0].text else{return}
            self.submit(text)
        }
        let backAction = UIAlertAction(title: "Reset All", style: .default){_ in
            self.resetButton()
        }
        ac.addAction(submitAction)
        ac.addAction(backAction)
        present(ac, animated: true)
        
        
    }
    @objc func organize(){
        let ac = UIAlertController(title: "Organize", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Organize", style: UIAlertAction.Style.default) { _ in
            guard let text = ac.textFields?[0].text else{return}
            self.organizem(text: text)
        }
        let resetAction = UIAlertAction(title: "Reset", style: UIAlertAction.Style.default) { _ in
            self.resetButton()
        }
        ac.addAction(submitAction)
        ac.addAction(resetAction)
        present(ac, animated: true)
    }
}
