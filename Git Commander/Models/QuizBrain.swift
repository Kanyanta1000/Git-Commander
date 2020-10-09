//
//  QuizBrain.swift
//  Git Commander
//
//  Created by Kanyanta Mubanga on 01.10.2020.
//

import Foundation

struct QuizBrain {
    let gitBasics = [
        Question(q: "Create empty Git repo in specified directory <directory>. Run with no arguments to initialize the current directory as a git repository.", a: "init", a2: "<directory>"),
        Question(q: "Clone repo located at <repo> onto local machine. Original repo can be located on the local filesystem or on a remote machine via HTTP or SSH.", a: "clone", a2: "<repo>"),
        Question(q: "Define author name to be used for all commits in current repo. Devs commonly use --global flag to set config options for current user.", a: "config user.name", a2: "<name>"),
        Question(q: "Stage all changes in <directory> for the next commit. Replace <directory> with a <file> to change a specific file.", a: "add <directory>", a2: "<directory>"),
        Question(q: "Commit the staged snapshot, but instead of launching a text editor, use <message> as the commit message.", a: "commit -m", a2: "\"<message>\""),
        Question(q: "List which files are staged, unstaged, and untracked.", a: "status", a2: ""),
        Question(q: "Display the entire commit history using the default format. For customization see additional options.", a: "log", a2: ""),
        Question(q: "Show unstaged changes between your index and working directory.", a: "diff", a2: "")
    ]
    
    var questionNumber = 0
    var score = 0
    
    mutating func checkAnswer(_ userAnswer: String) -> Bool {
        if gitBasics[questionNumber].answer == userAnswer {
            score += 1
            return true
        } else {
            return false
        }
    }
    
    mutating func incrementQuestionNumber() {
        if questionNumber < gitBasics.count - 1 {
            questionNumber += 1
        } else {
            questionNumber = 0
            score = 0
        }
    }
    
    func getHint() -> String {
        
        return gitBasics[questionNumber].answer
    }
    
    func getScore() -> Int {
        return score
    }
    
    func getQuestionText() -> String {
        return gitBasics[questionNumber].text
    }
    
    func getSecondaryArgument() -> String {
        return gitBasics[questionNumber].secondaryArgument ?? ""
    }
    
    func getProgress() -> Float {
        return Float(questionNumber + 1)/Float(gitBasics.count)
    }
    
}
