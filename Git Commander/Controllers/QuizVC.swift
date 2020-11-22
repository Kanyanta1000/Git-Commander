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
        
        answerTextField.delegate = self
        // answerTextField.becomeFirstResponder()
        answerTextField.autocorrectionType = .no
        addDoneButton()
        
        // Listening for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        self.setBackGround(bgImageView: bgImageView)    //programmatically setting bg from uiview extension
        navigationItem.title = currentQuiz?.title
        updateUI()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeRight.direction = .right
            self.view.addGestureRecognizer(swipeRight)

            let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeDown.direction = .left
            self.view.addGestureRecognizer(swipeDown)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
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
            sender.tintColor = UIColor.init(named: K.Colors.green)
            quizQuestionPageController.pageIndicatorTintColor = UIColor(named: K.Colors.green)
//            quizManager.incrementQuestionNumber()
            
        } else {
            sender.shake()
            sender.tintColor = UIColor.init(named: K.Colors.red)
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
        checkAnswerButton.tintColor = UIColor.init(named: K.Colors.green)
        nextQuestionButton.setImage(UIImage(systemName: K.rightIcon), for: .normal)
        questionLabel.text = quizManager.getQuestionText()
        scoreLabel.text = "Score: \(quizManager.getScore())"
        answerTextField.text = ""
        setStar()
    }
    
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                previousPressed(previousButton)
            
            case .left:
                nextPressed(nextQuestionButton)
            
            default:
                break
            }
        }
    }
}

extension QuizVC: UITextFieldDelegate {
    
    
    @objc func keyboardWillChange(notification: Notification) {
        
        var topbarHeight: CGFloat {
            return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
                (self.navigationController?.navigationBar.frame.height ?? 0.0)
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            view.frame.origin.y = topbarHeight - 100
            
        } else {
            view.frame.origin.y = topbarHeight
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        checkPressed(checkAnswerButton)
        hideKeyboard()
        
        return true
    }
    
    func hideKeyboard() {
        answerTextField.resignFirstResponder()
    }
    
    func addDoneButton() {
        
        let toolBar = UIToolbar()
        
        toolBar.sizeToFit()
        toolBar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        toolBar.setShadowImage(UIImage(), forToolbarPosition: .any)
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(image: UIImage(systemName: K.xmark), style: .plain, target: self, action: #selector(self.doneClicked))
        
        doneButton.tintColor = UIColor(named: K.Colors.textAndIcons)
        
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        
        answerTextField.inputAccessoryView = toolBar
        
    }
    
    @objc func doneClicked() {
        view.endEditing(true)
    }
}
