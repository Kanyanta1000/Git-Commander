//
//  ViewController.swift
//  Git Commander
//
//  Created by Kanyanta Mubanga on 30.09.2020.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var nextQuestionButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var secondaryArgLabel: UILabel!
    
    var quizBrain = QuizBrain()
    var quizTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(quizTitle)
        updateUI()
    }
    
    
    @IBAction func nextQuestionPressed(_ sender: UIButton) {
        var answerCorrect: Bool = false
        if let typedAnswer = answerTextField.text {
            answerCorrect = quizBrain.checkAnswer(typedAnswer)
        }
        
        if answerCorrect {
            sender.pulsate()
            quizBrain.incrementQuestionNumber()
            sender.backgroundColor = UIColor.init(named: "Dark Primary Color")
        } else {
            sender.shake()
            sender.backgroundColor = UIColor.init(named: "Light Primary Color")
        }
        
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }
    
    @IBAction func hintPressed(_ sender: UIButton) {
        
        let correctAnswer = quizBrain.getHint()
        
        let alert = UIAlertController(title: "Does this help?", message: "Number of letters: \(correctAnswer.count) \n First letter:  \(Array(correctAnswer)[0])", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "I give up", style: .default, handler: { (action) in
            self.answerTextField.text = correctAnswer
        }))

        self.present(alert, animated: true)
            
    }
    
    @objc func updateUI() {
        questionLabel.text = quizBrain.getQuestionText()
        secondaryArgLabel.text = quizBrain.getSecondaryArgument()
        progressBar.progress = quizBrain.getProgress()
        scoreLabel.text = "Score: \(quizBrain.getScore())"
        answerTextField.text = ""
    }
}
