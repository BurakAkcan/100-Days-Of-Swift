//
//  ViewController.swift
//  Proect5
//
//  Created by Burak AKCAN on 23.05.2022.
//

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(promptAnswer))
        if let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordsUrl){
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        if allWords.isEmpty {
            allWords = ["solucan deliği"]
        }
        startGame()
    }
    
    func startGame(){
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
   
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return usedWords.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    
    
    @objc func promptAnswer(){
        let ac = UIAlertController(title: "Enter", message: nil, preferredStyle: UIAlertController.Style.alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac ] action in
            guard let answer = ac?.textFields?[0].text else{return}
            self?.submit(answer)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    func submit(_ answer:String){
        let lowerAnswer = answer.lowercased()
        let errorTitle:String
        let errorMessage: String
        if isPossible(word: lowerAnswer){
            if isOrignal(word: lowerAnswer){
                if isReal(word: lowerAnswer){
                    usedWords.insert(lowerAnswer, at: 0)
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                    return
                    
                }else{
                    errorTitle = "Word not recognized"
                    errorMessage = "You cant just make them up, you know!"
                }
            }else{
                errorTitle = "Word already used"
                errorMessage = "Must be original"
            }
        }else{
            guard let title = title else{return}
            errorTitle = "Not possible"
            errorMessage = "You cant spell that word from \(title.lowercased()) "
        }
        
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: UIAlertController.Style.alert)
        ac.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        present(ac, animated: true)
        
    }
    
    func isPossible(word:String)->Bool{
        guard var tempWord = title?.lowercased() else{
            return false
        }
        for letter in word{
            if let position = tempWord.firstIndex(of: letter){
                tempWord.remove(at: position)
            }else {
                return false
            }
        }
        return true
    }
    func isOrignal(word:String)->Bool{
        return !usedWords.contains(word)
    }
    func isReal(word:String)->Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }


}


