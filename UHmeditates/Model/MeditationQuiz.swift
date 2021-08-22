//
//  MeditationQuiz.swift
//  UHmeditates
//
//  Created by Tyler Boston on 6/26/21.
//

import Foundation
import Firebase

struct MeditationQuiz {
    
    // Use for later code clean up
    //    let db = Firestore.firestore()
    //    var quizSubmission: [String : Any] = [:]
    //
    //    mutating func StoreAnswer () {
    //        quizSubmission
    //    }
    //
    //    func UploadAnswers () {
    //    }
    
    //1.1: Building out the survey
    let quiz = [
        Question(q: "Interested", a: K.KMeditationQuiz().answerArray),
        Question(q: "Distressed", a: K.KMeditationQuiz().answerArray),
        Question(q: "Excited", a: K.KMeditationQuiz().answerArray),
        Question(q: "Upset", a: K.KMeditationQuiz().answerArray),
        Question(q: "Strong", a: K.KMeditationQuiz().answerArray),
        Question(q: "Guilty", a: K.KMeditationQuiz().answerArray),
        Question(q: "Scared", a: K.KMeditationQuiz().answerArray),
        Question(q: "Hostile", a: K.KMeditationQuiz().answerArray),
        Question(q: "Proud", a: K.KMeditationQuiz().answerArray),
        Question(q: "Enthusiastic", a: K.KMeditationQuiz().answerArray),
        Question(q: "Irritable", a: K.KMeditationQuiz().answerArray),
        Question(q: "Alert", a: K.KMeditationQuiz().answerArray),
        Question(q: "Ashamed", a: K.KMeditationQuiz().answerArray),
        Question(q: "Inspired", a: K.KMeditationQuiz().answerArray),
        Question(q: "Determined", a: K.KMeditationQuiz().answerArray),
        Question(q: "Nervous", a: K.KMeditationQuiz().answerArray),
        Question(q: "Attentive", a: K.KMeditationQuiz().answerArray),
        Question(q: "Jittery", a: K.KMeditationQuiz().answerArray),
        Question(q: "Active", a: K.KMeditationQuiz().answerArray),
        Question(q: "Afraid", a: K.KMeditationQuiz().answerArray)]
    
    var questionNumber = 0 // starting point for quiz 
    static  var weekTitle = ""
    
    //MARK: Functions
    
    /// Grabs next question to be displayed on the UILabel
    mutating func nextQuestion () {
        if questionNumber != quiz.count - 1 {questionNumber += 1}
        else if questionNumber == quiz.count - 1 {questionNumber = 0}
    }
    
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

