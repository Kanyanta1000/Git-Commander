//
//  Question.swift
//  Git Commander
//
//  Created by Kanyanta Mubanga on 01.10.2020.
//


import Foundation
import RealmSwift

class Question: Object {
    @objc dynamic var text : String = ""
    @objc dynamic var answer : String = ""
    @objc dynamic var secondaryArgument : String? = nil
    @objc dynamic var isStarred = false
    let parentQuiz = LinkingObjects(fromType: Quiz.self, property: "questions")
    
    
    convenience init(q: String, a: String, a2: String?) {
        self.init()
        self.text = q
        self.answer = a
        self.secondaryArgument = a2
    }
}

