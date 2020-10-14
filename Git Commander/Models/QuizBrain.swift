//
//  QuizBrain.swift
//  Git Commander
//
//  Created by Kanyanta Mubanga on 01.10.2020.
//

import Foundation

struct QuizBrain {
    
    var quiz = quizBank().quizes[0]
    var questionNumber = 0
    var score = 0
    
    mutating func checkAnswer(_ userAnswer: String) -> Bool {
        if quiz.questions[questionNumber].answer == userAnswer {
            score += 1
            return true
        } else {
            return false
        }
    }
    
    mutating func incrementQuestionNumber() {
        if questionNumber < quiz.questions.count - 1 {
            questionNumber += 1
        } else {
            questionNumber = 0
            score = 0
        }
    }
    
    mutating func setQuiz(topic: String?) {
        if topic != nil {
            quiz = quizBank().quizes.first { $0.title == topic}!

        }
    }
    
    func getHint() -> String {
        return quiz.questions[questionNumber].answer
    }
    
    func getScore() -> Int {
        return score
    }
    
    func getQuestionText() -> String {
        return quiz.questions[questionNumber].text
    }
    
    func getSecondaryArgument() -> String {
        return quiz.questions[questionNumber].secondaryArgument ?? ""
    }
    
    func getProgress() -> Float {
        return Float(questionNumber + 1)/Float(quiz.questions.count)
    }
}
