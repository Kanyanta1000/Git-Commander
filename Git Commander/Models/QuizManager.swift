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
        let starredQuiz = realm.objects(Quiz.self).filter("title == %@", K.quizTitles.starred).first
        let currentQuestion = quiz.questions[questionNumber]
        
        do {
            try realm.write {
                currentQuestion.isStarred = !currentQuestion.isStarred
            }
        } catch  {
            print("Error bookmarking question: \(error)")
        }
        
        if currentQuestion.isStarred {
            do {
                try realm.write {
                    starredQuiz?.questions.append(quiz.questions[questionNumber])
                }
            } catch {
                print("Error adding question to Starred quiz question list: \(error)")
            }
            
        } else {
            if let questionIndex = starredQuiz?.questions.index(of: currentQuestion) {
                do {
                    try realm.write {
                        starredQuiz?.questions.remove(at: questionIndex)
                    }
                } catch {
                    print("Error removing question from Starred quiz question list: \(error)")
                }
            }
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
        return quiz.questions[questionNumber].isStarred 
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
