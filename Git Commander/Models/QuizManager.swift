//
//  QuizBrain.swift
//  Git Commander
//
//  Created by Kanyanta Mubanga on 01.10.2020.
//

import Foundation
import RealmSwift

class QuizManager {
    
    var quiz: Quiz!
    var questionNumber = 0
    var score = 0
    let realm = try! Realm()
    
    func checkAnswer(_ userAnswer: String) -> Bool {
        if quiz.questions[questionNumber].answer == userAnswer {
            score += 1
            return true
        } else {
            return false
        }
    }
    
    func incrementQuestionNumber() {
        if questionNumber < quiz.questions.count - 1 {
            questionNumber += 1
        } else {
            questionNumber = 0
            score = 0
        }
    }
    
    func decrementQuestionNumber() {
        if questionNumber > 0 {
            questionNumber -= 1
        } else {
            questionNumber = quiz.questions.count - 1
            score = 0
        }
    }
    
    func bookmarkQuestion() {
        do {
            try realm.write {
                quiz.questions[questionNumber].starred = !quiz.questions[questionNumber].starred
            }
        } catch  {
            print("Error bookmarking question: \(error)")
        }
    }
    
    func getHint() -> String {
        return quiz.questions[questionNumber].answer
    }
    
    func getScore() -> Int {
        return score
    }
    
    func getQuestionText() -> String {
        let questionText = "Question \(questionNumber + 1) of \(quiz.questions.count)\n\n \(quiz.questions[questionNumber].text)"
        return questionText
    }
    
    func isStarredQuestion() -> Bool {
        return quiz.questions[questionNumber].starred 
    }
    
    func getSecondaryArgument() -> String {
        return quiz.questions[questionNumber].secondaryArgument ?? ""
    }
    
    func getProgress() -> Float {
        let progress = Float(questionNumber + 1)/Float(quiz.questions.count)
        return progress
    }
    
    func getNumofQuestions() -> Int {
        return quiz.questions.count
    }
}
