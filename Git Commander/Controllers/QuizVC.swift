//
//  ViewController.swift
//  Git Commander
//
//  Created by Kanyanta Mubanga on 30.09.2020.
//

import UIKit
import RealmSwift

class QuizVC: UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet weak var quizQuestionPageController: UIPageControl!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var checkAnswerButton: UIButton!
    @IBOutlet weak var nextQuestionButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var hintButton: UIButton!

    
    var currentQuiz: Quiz! {
        didSet {
            quizManager.quiz = currentQuiz
        }
    }
    let bgImageView = UIImageView()
    var quizManager = QuizManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackGround(bgImageView: bgImageView)    //programmatically setting bg from uiview extension
        navigationItem.title = currentQuiz?.title
        updateUI()
    }
    
    @IBAction func previousPressed(_ sender: UIButton) {
        quizManager.decrementQuestionNumber()
        updateUI()
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
        quizManager.incrementQuestionNumber()
        updateUI()
    }
    
    @IBAction func checkPressed(_ sender: UIButton) {
        if questionLabel.text! == K.noQuestionsFoundText {
            return
        }
        
        var answerCorrect: Bool = false
        if let typedAnswer = answerTextField.text {
            answerCorrect = quizManager.checkAnswer(typedAnswer)
        }
        
        if answerCorrect {
            sender.pulsate()
            quizManager.incrementQuestionNumber()
            sender.backgroundColor = UIColor.init(named: K.Colors.darkPrimary)
        } else {
            sender.shake()
            sender.backgroundColor = UIColor.init(named: K.Colors.lightPrimary)
        }
        
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }
    
    @IBAction func hintPressed(_ sender: UIButton) {
        
        if questionLabel.text! == K.noQuestionsFoundText {
            return
        }
        
        
        let correctAnswer = quizManager.getHint()
        
        let alert = UIAlertController(title: "Does this help?", message: "Number of letters: \(correctAnswer.count) \n First letter:  \(Array(correctAnswer)[0])", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "I give up", style: .default, handler: { (action) in
            self.answerTextField.text = correctAnswer
        }))
        
        self.present(alert, animated: true)
    }
    
    @IBAction func starPressed(_ sender: Any) {
        if questionLabel.text! != K.noQuestionsFoundText {
            quizManager.bookmarkQuestion()
            updateUI()
        }
    }
    
    func setStar() {
        if quizManager.isStarredQuestion() {
            starButton.setImage(UIImage(systemName: K.starFill), for: .normal)
        } else {
            starButton.setImage(UIImage(systemName: K.star), for: .normal)
        }
    }
    
    
    @objc func updateUI() {
        let checkAnswerConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .light, scale: .medium)
        let answerButton = UIImage(systemName: K.answerIcon, withConfiguration: checkAnswerConfig)
        
        quizQuestionPageController.numberOfPages = quizManager.getNumofQuestions()
        hintButton.setImage(UIImage(systemName: K.hintIcon), for: .normal)
        previousButton.setImage(UIImage(systemName: K.leftIcon), for: .normal)
        checkAnswerButton.setImage(answerButton, for: .normal)
        nextQuestionButton.setImage(UIImage(systemName: K.rightIcon), for: .normal)
        questionLabel.text = quizManager.getQuestionText()
        scoreLabel.text = "Score: \(quizManager.getScore())"
        answerTextField.text = ""
        setStar()
    }
}
