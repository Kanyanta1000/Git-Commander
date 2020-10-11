//
//  QuizBrain.swift
//  Git Commander
//
//  Created by Kanyanta Mubanga on 01.10.2020.
//

import Foundation

struct QuizBrain {
    
    var quiz = quizBank().quizes["Git Basics"]!
    var questionNumber = 0
    var score = 0
    
    mutating func checkAnswer(_ userAnswer: String) -> Bool {
        if quiz[questionNumber].answer == userAnswer {
            score += 1
            return true
        } else {
            return false
        }
    }
    
    mutating func incrementQuestionNumber() {
        if questionNumber < quiz.count - 1 {
            questionNumber += 1
        } else {
            questionNumber = 0
            score = 0
        }
    }
    
    mutating func setQuiz(topic: String?) {
        if let selectedTopic = topic {
            quiz = quizBank().quizes[selectedTopic] ?? [Question]()
        }
    }
    
    func getHint() -> String {
        
        return quiz[questionNumber].answer
    }
    
    func getScore() -> Int {
        return score
    }
    
    func getQuestionText() -> String {
        return quiz[questionNumber].text
    }
    
    func getSecondaryArgument() -> String {
        return quiz[questionNumber].secondaryArgument ?? ""
    }
    
    func getProgress() -> Float {
        return Float(questionNumber + 1)/Float(quiz.count)
    }
}
