//
//  Quiz.swift
//  Git Commander
//
//  Created by Kanyanta Mubanga on 14.10.2020.
//

import Foundation
import RealmSwift

class Quiz: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var icon : String = ""
    let questions = List<Question>()
    
    convenience init(title: String, icon: String, question: Question?) {
        self.init()
        self.title = title
        self.icon = icon
//        self.questions.append(question!)
    }
}
