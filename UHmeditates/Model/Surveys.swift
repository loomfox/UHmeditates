//
//  FormTask.swift
//  UHmeditates
//
//  Created by Tyler Boston on 8/6/21.
//MARK: 1.0: Completing the Form View
//      1.1: Cleaning up the Questionnaire 

import Foundation
import ResearchKit
import CareKit

struct Surveys {
    
    static func onboardingSurvey() -> ORKTask {
        var onboardingSteps = [ORKStep]()
        
        //1.4.1 Welcome step
        let welcomeStep = ORKInstructionStep(identifier: "onboarding.welcome")
        welcomeStep.title = "Welcome to UHMeditates!"
        welcomeStep.detailText = "Thanks for joining the study, tap next to learn more about your role in the app"
        welcomeStep.image = UIImage(named: "Happy") // ommit if no need to for image
        onboardingSteps += [welcomeStep]
        
        //1.4.2 Instruction step with body items
        let studyOverViewInstructionStep = ORKInstructionStep(identifier: "onboarding.overview")
        studyOverViewInstructionStep.title = "Overview"
        studyOverViewInstructionStep.image = UIImage(named: "Happy")
        onboardingSteps += [studyOverViewInstructionStep]
        
        let pointOne = ORKBodyItem(
            text: "Probably should remind them of how their heart rate is collected and if need be, create another instruction step for rules/reminders}", detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .image)
        
        let pointTwo = ORKBodyItem(
            text: "Point for important information or further instruction", detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint)
        
        let pointThree = ORKBodyItem(
            text: "Point for important information or further instruction", detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .horizontalRule)
        
        let pointFour = ORKBodyItem(
            text: "Point for important information or further instruction", detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .text)
        
        let pointFive = ORKBodyItem(
            text: "Point for important information or further instruction", detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .tag)
        
        studyOverViewInstructionStep.bodyItems = [pointOne, pointTwo, pointThree, pointFour, pointFive]
        
        //1.4.3 Permissions
        let notificationPermisisonType = ORKNotificationPermissionType(authorizationOptions: [.alert, .badge, .sound])
        
        //Pass into a request permission
        
        let requestPermissionStep = ORKRequestPermissionsStep(identifier: "onboarding.permissionRequestStep", permissionTypes: [notificationPermisisonType])
        onboardingSteps += [requestPermissionStep]
        
        //1.4.4 Completion Step
        let completionStep = ORKCompletionStep(identifier: "onboarding.completion")
        completionStep.title = "Thanks for joining the study!"
        completionStep.detailText = "You are now ready to access the rest of the app!"
        onboardingSteps += [completionStep]
        
        let introductionSurvey = ORKOrderedTask(identifier: "onboarding.introductionStep", steps: onboardingSteps)
        
        return introductionSurvey
    }
    
    static func showMeditationSurvey() -> ORKTask {
        
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
        let Q2Item = ORKFormItem(identifier: "Q2", text: QTC[1].text, answerFormat: Q1AF)
        let Q3Item = ORKFormItem(identifier: "Q3", text: QTC[2].text, answerFormat: Q1AF)
        let Q4Item = ORKFormItem(identifier: "Q4", text: QTC[3].text, answerFormat: Q1AF)
        let Q5Item = ORKFormItem(identifier: "Q5", text: QTC[4].text, answerFormat: Q1AF)
        let Q6Item = ORKFormItem(identifier: "Q6", text: QTC[5].text, answerFormat: Q1AF)
        let Q7Item = ORKFormItem(identifier: "Q7", text: QTC[6].text, answerFormat: Q1AF)
        let Q8Item = ORKFormItem(identifier: "Q8", text: QTC[7].text, answerFormat: Q1AF)
        let Q9Item = ORKFormItem(identifier: "Q9", text: QTC[8].text, answerFormat: Q1AF)
        let Q10Item = ORKFormItem(identifier: "Q10", text: QTC[9].text, answerFormat: Q1AF)
        let Q11Item = ORKFormItem(identifier: "Q11", text: QTC[10].text, answerFormat: Q1AF)
        let Q12Item = ORKFormItem(identifier: "Q12", text: QTC[11].text, answerFormat: Q1AF)
        let Q13Item = ORKFormItem(identifier: "Q13", text: QTC[12].text, answerFormat: Q1AF)
        let Q14Item = ORKFormItem(identifier: "Q14", text: QTC[13].text, answerFormat: Q1AF)
        let Q15Item = ORKFormItem(identifier: "Q15", text: QTC[14].text, answerFormat: Q1AF)
        let Q16Item = ORKFormItem(identifier: "Q16", text: QTC[15].text, answerFormat: Q1AF)
        let Q17Item = ORKFormItem(identifier: "Q17", text: QTC[16].text, answerFormat: Q1AF)
        let Q18Item = ORKFormItem(identifier: "Q18", text: QTC[17].text, answerFormat: Q1AF)
        let Q191Item = ORKFormItem(identifier: "Q19", text: QTC[18].text, answerFormat: Q1AF)
        let Q20Item = ORKFormItem(identifier: "Q20", text: QTC[19].text, answerFormat: Q1AF)
        allQuestionItem += [Q1Item, Q2Item, Q3Item, Q4Item, Q5Item, Q6Item, Q7Item, Q8Item, Q9Item, Q10Item, Q11Item, Q12Item, Q13Item, Q14Item, Q15Item, Q16Item, Q17Item, Q18Item, Q191Item, Q20Item]
        
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
}
