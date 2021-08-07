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
    
    
    
    init(q: String, a: [String]) {
        text = q
        answer = a
        
    }
}
