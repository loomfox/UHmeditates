//
//  SurveyTask.swift
//  UHmeditates
//
//  Created by Tyler Boston on 8/5/21.
//

import UIKit
import ResearchKit

// this may need to come out of the class 
//class SurveyTaskVC: ORKStepViewController {
//    
//    public var SurveyTask: ORKFormStep {
//        
//        var steps = [ORKFormItem]()
//        
//        //Introduction
////        let instructionStep = ORKInstructionStep(identifier: "IntroStep")
////        instructionStep.title = "Test Survey"
////        instructionStep.text = "Answer three questions to complete the survey."
////        steps += [instructionStep]
//        
//        //Text Input Question
//        let nameAnswerFormat = ORKTextAnswerFormat(maximumLength: 20)
//        let nameQuestionStepTitle = "What is your name?"
//        let nameQuestionStep = ORKFormItem(identifier: "NameStep", text: nameQuestionStepTitle, answerFormat: nameAnswerFormat)
//        steps += [nameQuestionStep]
//        
//        //Image Input Question
//        let moodQuestion = "How do you feel today?"
//        let moodImages = [
//            (UIImage(named: "Happy")!, "Happy"),
//            (UIImage(named: "Angry")!, "Angry"),
//            (UIImage(named: "Sad")!, "Sad"),
//        ]
//        let moodChoice : [ORKImageChoice] = moodImages.map {
//            return ORKImageChoice(normalImage: $0.0, selectedImage: nil, text: $0.1, value: $0.1 as NSCoding & NSCopying & NSObjectProtocol)
//        }
//        let answerFormat: ORKImageChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: moodChoice)
//        let moodQuestionStep = ORKFormItem(identifier: "MoodStep", text: moodQuestion, answerFormat: answerFormat)
//        steps += [moodQuestionStep]
//        
//        //Numeric Input Question
//        let ageQuestion = MeditationQuiz().quiz[1].text
//        let ageAnswer = ORKNumericAnswerFormat.integerAnswerFormat(withUnit: "years")
//        ageAnswer.minimum = 18
//        ageAnswer.maximum = 85
//        let ageQuestionStep = ORKFormItem(identifier: "AgeStep", text: ageQuestion, answerFormat: ageAnswer)
//        steps += [ageQuestionStep]
//        
//        
//        //Summary
////        let completionStep = ORKCompletionStep(identifier: "SummaryStep")
////        completionStep.title = "Thank You!!"
////        completionStep.text = "You have completed the survey"
////        steps += [completionStep]
////
//        //MARK: Theory #1: For collecting results using delegates
//        //    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
//        //        if let stepResult = taskViewController.result.stepResult(forStepIdentifier: "NameStep") {
//        //            let stepResults = stepResult.results
//        //            let stepNameResult = stepResults?.first
//        //            let Result = stepNameResult as? ORKTextQuestionResult
//        //            print(Result?.textAnswer as Any)
//        //        }
//        //        taskViewController.dismiss(animated: true, completion: nil)
//        //    }
//        //
//        //        taskViewController(SurveyTaskVC, didFinishWith: ORKTaskViewControllerFinishReason, error: Error? as! Error)
//        // I think i need to optional bind e to error like angela
//        return ORKFormStep(identifier: "SurveyTask")
//        
//    }
//}
