//
//  ViewController.swift
//  Git Commander
//
//  Created by Kanyanta Mubanga on 30.09.2020.
//

import UIKit

class QuizViewController: UIViewController {

    @IBOutlet weak var quizQuestionPageController: UIPageControl!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var nextQuestionButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var starButton: UIButton!
    
    let bgImageView = UIImageView()
    var quizBrain = QuizManager()
    var quizTitle: String? {
        didSet {
            quizBrain.setQuiz(topic: quizTitle)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    @IBAction func previousPressed(_ sender: UIButton) {
        quizBrain.decrementQuestionNumber()
        updateUI()
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
        quizBrain.incrementQuestionNumber()
        updateUI()
    }
    
    @IBAction func checkPressed(_ sender: UIButton) {
        var answerCorrect: Bool = false
        if let typedAnswer = answerTextField.text {
            answerCorrect = quizBrain.checkAnswer(typedAnswer)
        }
        
        if answerCorrect {
            sender.pulsate()
            quizBrain.incrementQuestionNumber()
            sender.backgroundColor = UIColor.init(named: K.Colors.darkPrimary)
        } else {
            sender.shake()
            sender.backgroundColor = UIColor.init(named: K.Colors.lightPrimary)
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
    
    @IBAction func starPressed(_ sender: Any) {
        quizBrain.bookmarkQuestion()
        setStar()
    }
    
    @objc func updateUI() {
        self.setBackGround(bgImageView: bgImageView)    //programmatically setting bg from uiview extension
        quizQuestionPageController.numberOfPages = quizBrain.getNumofQuestions()
        self.navigationItem.title = quizTitle
        questionLabel.text = quizBrain.getQuestionText()
        scoreLabel.text = "Score: \(quizBrain.getScore())"
        answerTextField.text = ""
        setStar()
    }
    
    func setStar() {
        if quizBrain.isStarredQuestion() {
            starButton.setImage(UIImage(systemName: K.starFill), for: .normal)
        } else {
            starButton.setImage(UIImage(systemName: K.star), for: .normal)
        }
    }
}
