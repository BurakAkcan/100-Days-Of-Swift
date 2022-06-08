////
////  DersViewController.swift
////  Project9
////
////  Created by Burak AKCAN on 7.06.2022.
////
//
//import UIKit
//
//class DersViewController: UIViewController {
//    var petitions:[Petition] = []
//    var mainItems = [Petition]()
//    var filteredItems = [Petition]()
//    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        performSelector(inBackground: #selector(fetchJson), with: nil   )
//
//    }
//   @objc func fetchJson(){
//        let urlString:String
//
//        if navigationController?.tabBarItem.tag == 0 {
//            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
//        }else{
//            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
//        }
//
//        if let url = URL(string: urlString){
//            if let data = try? Data(contentsOf: url){
//                parseData(json: data)
//                return
//            }
//        }
//       performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
//    }
//
//   @objc func showError(){
//
//            let ac = UIAlertController(title:"Loading Error", message: "Opss you have a bad link ", preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "ok", style: .default))
//            present(ac, animated: true)
//    }
//
//
//
//    func parseData(json:Data){
//        let decoder = JSONDecoder()
//        if let jsonPetition = try? decoder.decode(Petitions.self, from: json){
//
//            petitions = jsonPetition.results
//            tableView.reloadData()
//            mainItems = petitions
//            tableView.performsSelector(performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false))
//        }else{
//            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
//        }
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return petitions.count
//    }
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let petition = petitions[indexPath.row]
//        cell.textLabel?.text = petition.title
//        cell.detailTextLabel?.text = petition.body
//        return cell
//    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = DetailViewController()
//        vc.detailItem = petitions[indexPath.row]
//        navigationController?.pushViewController(vc, animated: true)
//    }
//    func submit(_ text:String){
//        filteredItems.removeAll()
//        for petition in petitions {
//            if petition.title.lowercased().contains(text.lowercased()){
//                filteredItems.append(petition)
//            }
//        }
//        if filteredItems.isEmpty {return}
//        petitions = filteredItems
//        tableView.reloadData()
//
//    }
//
//    func resetAll(){
//        petitions = mainItems
//        tableView.reloadData()
//
//    }
//
//
//}
//
//extension DersViewController{
//    @objc func wordFilter(){
//
//        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
//        ac.addTextField()
//        let submitAction = UIAlertAction(title: "Find", style: .default) { _ in
//            guard let text = ac.textFields?[0].text else{return}
//            self.submit(text)
//        }
//        let backAction = UIAlertAction(title: "Reset All", style: .default) { _ in
//            self.resetAll()
//        }
//        ac.addAction(submitAction)
//        ac.addAction(backAction)
//        present(ac, animated: true)
//
//    }
//    @objc func credit(){
//        let ac = UIAlertController(title: "Your Data ", message: "Data comes from White House", preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//        present(ac, animated: true)
//    }
//
//}
