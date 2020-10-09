//
//  Question.swift
//  Git Commander
//
//  Created by Kanyanta Mubanga on 01.10.2020.
//


import Foundation

struct Question {
    let text : String
    let answer : String
    let secondaryArgument : String?
    
    init(q: String, a: String, a2: String?) {
        text = q
        answer = a
        secondaryArgument = a2 ?? ""
    }
}

