//
//  ViewController.swift
//  Project8
//
//  Created by Burak AKCAN on 2.06.2022.
//

import UIKit

class ViewController: UIViewController {
    var cluesLabel:UILabel!
    var answerLabel :UILabel!
    var currentAnswer:UITextField!
    var scoreLabel:UILabel!
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    var score = 0 {
//Burası score nezaman değişirse scoreLabel da her zaman değişicektir
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    var level = 1
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.text = "CLUES"
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        cluesLabel.numberOfLines = 0 //Metnin kaç satır kaydırılacağını belirleyen tamsayıdır, aldığı kadar çok satır anlamına gelir
        view.addSubview(cluesLabel)
        
        answerLabel = UILabel()
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.font = UIFont.systemFont(ofSize: 24) //UIFont(name: "Arial", size: 21) Bu şekilde de yazılabilir
        answerLabel.text = "ANSWER"
        answerLabel.textAlignment = .right
        answerLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        answerLabel.numberOfLines = 0
        view.addSubview(answerLabel)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
        
        
        
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("Submit", for: .normal)
//touchUpInside kullanıcı düğmeye bastığı ve düğme içerdeyken dokunuşu kaldırıdığını söylemenin yoludur .
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside )
        view.addSubview(submit)
        
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("Clear", for: .normal)
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        view.addSubview(clear)
        
        let buttonViews = UIView()
        buttonViews.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonViews)
        
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
            answerLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            answerLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
            answerLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -10),
            answerLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            //submit ve clear butonu yanyana koymak için 100 çıkardık diğerinede 100 ekleyeceğiz
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            submit.heightAnchor.constraint(equalToConstant: 44),
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            //submit butonuyla yüksekliği aynı yaptık
            clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
            clear.heightAnchor.constraint(equalToConstant: 44),
            buttonViews.widthAnchor.constraint(equalToConstant: 750),
            buttonViews.heightAnchor.constraint(equalToConstant: 320),
            buttonViews.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //bu buttonViews adında bir container oluşturuyoruz ve bunun en üst noktası submit butonun en altı olsun ve arada 20 boşluk olsun
            buttonViews.topAnchor.constraint(equalTo: submit.bottomAnchor,constant: 20),
            buttonViews.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor,constant: -20)
            
            
        ])
        let height = 80
        let width = 150
        
        for row in 0..<4{
            for column in 0..<5{
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                letterButton.setTitle("WWW", for: .normal)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                
                let frame = CGRect(x: column * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                buttonViews.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
        }
        
       
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadLevel()
        
    }
    
    @objc func letterTapped(_ sender:UIButton){
        guard let butonTitle = sender.titleLabel?.text else {return}
        currentAnswer.text = currentAnswer.text?.appending(butonTitle)
        activatedButtons.append(sender)
        sender.isHidden = true
        
    }
    @objc func submitTapped(_ sender:UIButton){
        
        guard let answerText = currentAnswer.text else {return}
        
        if let solutionPosition = solutions.firstIndex(of: answerText){
            activatedButtons.removeAll()
            var splitAnswer = answerLabel.text?.components(separatedBy: "\n")
            splitAnswer?[solutionPosition] = answerText
            answerLabel.text = splitAnswer?.joined(separator: "\n")
            
            currentAnswer.text = ""
            score += 1
            if score % 7 == 0{
                let ac = UIAlertController(title: "Well Done", message: "Are you ready next level", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Lets Go", style: .default,handler: levelUp))
                present(ac, animated: true)
                
            }
        }
        
        
    }
    
    func levelUp(action:UIAlertAction){
        level += 1
        solutions.removeAll(keepingCapacity: true)
        loadLevel()
        
        for button in letterButtons{
            button.isHidden = false
        }
        
    }
    
    @objc func clearTapped(_ sender:UIButton){
        currentAnswer.text = ""
        for button in activatedButtons{
            button.isHidden = false
        }
        activatedButtons.removeAll()
        
    }
    func loadLevel(){
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        if let levelFileUrl = Bundle.main.url(forResource: "level\(level)", withExtension: "txt"){
            if let levelContents = try? String(contentsOf: levelFileUrl){
                var lines = levelContents.components(separatedBy: "\n")
                lines.shuffle()
                print(lines)
                
                for (index,line) in lines.enumerated(){
                    let parts = line.components(separatedBy: ": ")
                    print(parts)
                    
                    let answer=parts[0]
                    let clue = parts[1]
                    
                    clueString += "\(index + 1). \(clue) \n"
//replacingOccurrences string ifade de yer değiştrmek istediğimiz ifade of dur yerine gelcek ifade with dir.
                    let solutionsWord = answer.replacingOccurrences(of: "|", with: "")
                    solutionString += "\(solutionsWord.count) letters \n"
                    solutions.append(solutionsWord)
                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                }
            }
        }
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answerLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        letterButtons.shuffle()
        
        if letterButtons.count == letterBits.count{
            for i in 0..<letterButtons.count{
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
        }
    }


}

