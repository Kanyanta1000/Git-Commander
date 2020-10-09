//
//  QuizBrain.swift
//  Git Commander
//
//  Created by Kanyanta Mubanga on 01.10.2020.
//

import Foundation

struct QuizBrain {
    struct quizBank {
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
        
        let undoingChanges = [
            Question(q: "Create new commit that undoes all of the changes made in <commit>, then apply it to the current branch.", a: "revert", a2: "<commit>"),
            Question(q: "Remove <file> from the staging area, but leave the working directory unchanged. This unstages a file without overwriting any changes.", a: "reset", a2: "<file>"),
            Question(q: "Remove <file> from the staging area, but leave the working directory unchanged. This unstages a file without overwriting any changes.", a: "clean", a2: "-n")
        ]  
    }
    
    var quiz = quizBank().undoingChanges
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
