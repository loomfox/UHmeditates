//
//  Question.swift
//  UHmeditates
//
//  Created by Tyler Boston on 6/26/21.
//

import Foundation

struct Question {
    let text: String
    let answer: [String]
    let chosenAnswer: String
    
    //MARK: TASK:  figure out if correct answer needs to be replaced with chosen answer or is that already the answer variable
    init(q: String, a: [String], selectedAnswer: String) {
        text = q
        answer = a
        chosenAnswer = selectedAnswer
    }
}
