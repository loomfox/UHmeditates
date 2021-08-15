//
//  MeditationQuiz.swift
//  UHmeditates
//
//  Created by Tyler Boston on 6/26/21.
//

import Foundation

struct MeditationQuiz {
    //MARK: TASK: View the Quiz on either firebase or Qualtrics website and complete the structure
    let quiz = [
        Question(q: "Excited", a:["Very slightly or not at all", "A little", "Moderately", "Quite a bit", "Extremely"], selectedAnswer: "Test3"),
        
        Question(q: "Upset", a:["Very slightly or not at all", "A little", "Moderately", "Quite a bit", "Extremely"], selectedAnswer: "A little"),
        
        Question(q: "Happy (NiS)", a:["Very slightly or not at all", "A little", "Moderately", "Quite a bit", "Extremely"], selectedAnswer: "Test3")]
    
    var questionNumber = 0 // starting point for quiz
    var score = 0
    
    //MARK: Functions
    
        /// Grabs next question to be displayed on the UILabel
    mutating func nextQuestion () {
        if questionNumber != quiz.count - 1 {questionNumber += 1}
        else if questionNumber == quiz.count - 1 {questionNumber = 0
            score = 0}
    }
    
        /// For setting the score
    func getScore() -> Int {
        return score
    }
    
    
//    mutating func checkAnswer(_ userAnswer: String!) -> Bool {
//        if userAnswer == quiz[questionNumber].rightAnswer {score += 1
//            return true }
//        else {
//            return false}
        
    
    func getQuestionText () -> String {
        return quiz[questionNumber].text
    }
    
    func getAnswerText () -> [String] {
        let questionAnswer: [String] = [quiz[questionNumber].answer[0],
                                        quiz[questionNumber].answer[1],
                                        quiz[questionNumber].answer[2],
                                        quiz[questionNumber].answer[3],
                                        quiz[questionNumber].answer[2]]
        return questionAnswer
    }
    
    func getProgress() -> Float {
        let progress = Float(questionNumber + 1) / Float(quiz.count)
        return progress
    }
}

