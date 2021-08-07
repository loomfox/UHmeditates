//
//  FormTask.swift
//  UHmeditates
//
//  Created by Tyler Boston on 8/6/21.
//MARK: 1.0: Completing the Form View
//      1.1: Cleaning up the Questionnaire 

import Foundation
import ResearchKit

func showMeditationSurvey() -> ORKTask {
    
    //ORKStep #1: Introduction
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Test Survey"
    instructionStep.text = "Answer three questions to complete the survey."
   
    // 1.2 Building out the questions into an array (Determine how to condense into a loop later)
    var allQuestionItem = [ORKFormItem]()
    
    let QTC = MeditationQuiz().quiz
    let QAC = [
        ORKTextChoice(text: K.KMeditationQuiz().answerArray[0], value: 0 as NSNumber),
        ORKTextChoice(text: K.KMeditationQuiz().answerArray[1], value: 1 as NSNumber),
        ORKTextChoice(text: K.KMeditationQuiz().answerArray[2], value: 2 as NSNumber),
        ORKTextChoice(text: K.KMeditationQuiz().answerArray[3], value: 3 as NSNumber),
        ORKTextChoice(text: K.KMeditationQuiz().answerArray[4], value: 4 as NSNumber)]
    let Q1AF: ORKTextChoiceAnswerFormat = .choiceAnswerFormat(with: .singleChoice, textChoices: QAC)
    let Q1Item = ORKFormItem(identifier: "Q1", text: QTC[0].text, answerFormat: Q1AF)
    allQuestionItem += [Q1Item]
    
    //Form Items
    //Item #1: Image Input Question
    
    let moodQuestion = "How do you feel today?"
    let moodImages = [
        (UIImage(named: "Happy")!, "Happy"),
        (UIImage(named: "Angry")!, "Angry"),
        (UIImage(named: "Sad")!, "Sad"),]
    
    let moodChoice : [ORKImageChoice] = moodImages.map {
        return ORKImageChoice(normalImage: $0.0, selectedImage: nil, text: $0.1, value: $0.1 as NSCoding & NSCopying & NSObjectProtocol)
    }
    
    let answerFormat: ORKImageChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: moodChoice)
    let moodQuestionItem = ORKFormItem(identifier: "MoodStep", text: moodQuestion, answerFormat: answerFormat)
    allQuestionItem += [moodQuestionItem]
    
    //Item #2: Numeric Input Question
    let ageQuestion = "How old are you?"
    let ageAnswer = ORKNumericAnswerFormat.integerAnswerFormat(withUnit: "years")
    ageAnswer.minimum = 18
    ageAnswer.maximum = 85
    let ageQuestionItem = ORKFormItem(identifier: "AgeStep", text: ageQuestion, answerFormat: ageAnswer)
    allQuestionItem += [ageQuestionItem]
    
    //ORKStep #2: Form
    let formQuestionStep = ORKFormStep(identifier: "TestFormStep", title: "Test-Form-Step", text: "This is a Test Form Step")
    formQuestionStep.isOptional = true
    formQuestionStep.formItems = allQuestionItem
    
    //ORKStep #3: Completion Step
    let completionStep = ORKCompletionStep(identifier: "CompletionStep")
    completionStep.title = "Congratulations!"
    completionStep.detailText = "You have just completed 1 of 3 daily tasks."
    
    let surveyTask = ORKOrderedTask(identifier: "MeditationTask", steps: [instructionStep, formQuestionStep, completionStep])
    
    return surveyTask
}
