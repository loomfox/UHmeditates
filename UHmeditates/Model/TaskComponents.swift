//
//  TaskComponents.swift
//  UHmeditates

// STATUS: 🟢 == Fully Functioning, 🟡 == Useable State but not complete, 🔴 == Not functioning
// ⚠️ == Missing Component
// 🔶 == Question
// ✅ == Part Completed
// ❌ == Part Incomplete

import ResearchKit


struct TaskComponents {
    
    private init () {}
    
    
    // MARK: 🔶 QUESTION: Should I create a separate structure for the survey elements (pre, medAudio, and post) so it's easier to duplicate?
    struct MeditationQuiz {
        
        // Question == structure of the questions and the required initializer parameters
        struct Question {

            let text: String
            
            init(q: String) {
                text = q
            }
        }

        // Quiz will be used to create 20 form items (or questions) which will have an answer from the K.CheckInSurveyTask().answerArray
        let form = [
            Question(q: "Interested"),
            Question(q: "Distressed"),
            Question(q: "Excited"),
            Question(q: "Upset"),
            Question(q: "Strong"),
            Question(q: "Guilty"),
            Question(q: "Scared"),
            Question(q: "Hostile"),
            Question(q: "Proud"),
            Question(q: "Enthusiastic"),
            Question(q: "Irritable"),
            Question(q: "Alert"),
            Question(q: "Ashamed"),
            Question(q: "Inspired"),
            Question(q: "Determined"),
            Question(q: "Nervous"),
            Question(q: "Attentive"),
            Question(q: "Jittery"),
            Question(q: "Active"),
            Question(q: "Afraid")
        ]
    }
    
    
    static func showOnboardingSurvey() -> ORKTask {
        //MARK: STATUS: 🟢
        var onboardingSteps = [ORKStep]()
        
        // MARK: ORKStep 1 of 4: ORKInstructionStep
        let welcomeStep = ORKInstructionStep(identifier: "\(K.TaskIDs.onboardingTaskID).welcome")
        welcomeStep.title = "Welcome to UHMeditates!"
        welcomeStep.detailText = "Thanks for joining the study, tap next to learn more about your role in the app"
        welcomeStep.image = UIImage(named: "Happy") // ommit if no need to for image
        onboardingSteps += [welcomeStep]
        
        // MARK: ORKStep 2 of 4: ORKInstructionStep with ORKBodyItems
        let studyOverViewInstructionStep = ORKInstructionStep(identifier: "\(K.TaskIDs.onboardingTaskID).overview")
        studyOverViewInstructionStep.title = "Overview"
        studyOverViewInstructionStep.image = UIImage(named: "Happy")
        onboardingSteps += [studyOverViewInstructionStep]
        
        // pointOne-Five are in useable state and will be populated with the right content later.
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
        
        // MARK: Notification Permissions to be Requested for Reminder Alerts
        let notificationPermisisonType = ORKNotificationPermissionType(authorizationOptions: [.alert, .badge, .sound])
        
        // MARK: ORKStep 3 of 4: ORKRequestPermissionsStep
        let requestPermissionStep = ORKRequestPermissionsStep(identifier: "\(K.TaskIDs.onboardingTaskID).permissionRequestStep", permissionTypes: [notificationPermisisonType])
        onboardingSteps += [requestPermissionStep]
        
        // MARK: ORKStep 4 of 4: ORKCompletionStep
        let completionStep = ORKCompletionStep(identifier: "\(K.TaskIDs.onboardingTaskID).completion")
        completionStep.title = "Thanks for joining the study!"
        completionStep.detailText = "You are now ready to access the rest of the app!"
        onboardingSteps += [completionStep]
        
        // MARK: Last Step for Completion of IntroductionSurvey
        let surveyTask = ORKOrderedTask(identifier: K.TaskIDs.onboardingTaskID, steps: onboardingSteps)
        return surveyTask
    }
    
    // showMeditationSurvey should have preSurvey, meditationAudio, and postSurvey
    static func showCheckInSurveyTask() -> ORKTask {
        // MARK: STATUS: 🟡 - Need to implement meditation audio step
        
        // MARK: ✅ Basic Components for both Pre and Post SurveyFormStep
       
        // QTC == Question Title Choices or basically the questions that require a response
        let QTC = MeditationQuiz().form
        
        // QAC == Question Answer Choice, it pulls text from a specific position in the K.KmeditationQuiz().answerArray
        let QAC = [
            ORKTextChoice(text: K.CheckInSurveyTask().answerArray[0], value: 0 as NSNumber),
            ORKTextChoice(text: K.CheckInSurveyTask().answerArray[1], value: 1 as NSNumber),
            ORKTextChoice(text: K.CheckInSurveyTask().answerArray[2], value: 2 as NSNumber),
            ORKTextChoice(text: K.CheckInSurveyTask().answerArray[3], value: 3 as NSNumber),
            ORKTextChoice(text: K.CheckInSurveyTask().answerArray[4], value: 4 as NSNumber)]
        
        // QAF = Question Answer Format to be used within ORKFormItem(answerFormat:)
        let QAF: ORKTextChoiceAnswerFormat = .choiceAnswerFormat(with: .singleChoice, textChoices: QAC)
       
        // MARK: ✅ ORKStep 1 of 5: ORKIntroductionStep
        let instructionStep = ORKInstructionStep(identifier: "\(K.TaskIDs.checkInTaskID).introStep")
        instructionStep.title = "Instructions for Check In Survey"
        instructionStep.text = "Answer questions to complete the survey."
        
        // MARK: 🔶 QUESTION: How can I condense this code?
        var allPreQuestionItem = [ORKFormItem]()
        var allPostQuestionItem = [ORKFormItem]()
        
        
        // MARK: ✅ ORKStep 2 of 5: ORKFormStep for Pre Survey
        
        // Q#Item == Single question being added to the form
        let preQ1Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q1", text: QTC[0].text, answerFormat: QAF)
        let preQ2Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q2", text: QTC[1].text, answerFormat: QAF)
        let preQ3Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q3", text: QTC[2].text, answerFormat: QAF)
        let preQ4Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q4", text: QTC[3].text, answerFormat: QAF)
        let preQ5Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q5", text: QTC[4].text, answerFormat: QAF)
        let preQ6Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q6", text: QTC[5].text, answerFormat: QAF)
        let preQ7Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q7", text: QTC[6].text, answerFormat: QAF)
        let preQ8Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q8", text: QTC[7].text, answerFormat: QAF)
        let preQ9Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q9", text: QTC[8].text, answerFormat: QAF)
        let preQ10Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q10", text: QTC[9].text, answerFormat: QAF)
        let preQ11Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q11", text: QTC[10].text, answerFormat: QAF)
        let preQ12Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q12", text: QTC[11].text, answerFormat: QAF)
        let preQ13Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q13", text: QTC[12].text, answerFormat: QAF)
        let preQ14Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q14", text: QTC[13].text, answerFormat: QAF)
        let preQ15Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q15", text: QTC[14].text, answerFormat: QAF)
        let preQ16Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q16", text: QTC[15].text, answerFormat: QAF)
        let preQ17Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q17", text: QTC[16].text, answerFormat: QAF)
        let preQ18Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q18", text: QTC[17].text, answerFormat: QAF)
        let preQ191Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q19", text: QTC[18].text, answerFormat: QAF)
        let preQ20Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q20", text: QTC[19].text, answerFormat: QAF)
        
        // allPreQuestionItem == [ORKFormItem] that will be put into an ORKFormStep for the preSurvey
        allPreQuestionItem += [preQ1Item, preQ2Item, preQ3Item, preQ4Item, preQ5Item, preQ6Item, preQ7Item, preQ8Item, preQ9Item, preQ10Item, preQ11Item, preQ12Item, preQ13Item, preQ14Item, preQ15Item, preQ16Item, preQ17Item, preQ18Item, preQ191Item, preQ20Item]
        
        
        let preFormStep = ORKFormStep(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form", title: "preSurvey Step", text: "This is the preSurvey ORKFormStep")
        preFormStep.isOptional = true
        preFormStep.formItems = allPreQuestionItem
        
        // MARK: ❌ ORKStep 3 of 5: ORKVideoInstructionStep (Implemented but not correctly fetching video URL)
        let url = "Replace with object that will change based on how many meditations left for the week"
        
        switch url {
        case "Meditation Task 1/3" : "Then Load this Specific Video File / URL"
        case "Meditation Task 2/3" : "Then Load this Specific Video File / URL"
        case "Meditation Task 3/3" : "Then Load this Specific Video File / URL"
        default: "Error Message: Video obviously didn't load"
        }
        
        let audioStep = ORKVideoInstructionStep(identifier: "\(K.TaskIDs.checkInTaskID).meditationAudio")
        audioStep.title = "This is an Audio Step"
        audioStep.detailText = "This hasn't been implemented fully yet, but should feature a preloaded meditation audio based on the week / task"
        audioStep.isOptional = true
        audioStep.videoURL = URL(string: url) // This isn't correct, needs to be pointing to a locally stored file.
        audioStep.thumbnailTime = 15 // Time in seconds at which the thumbnail image should be created
  
        // MARK: ✅ ORKStep 4 of 5: ORKFormStep for Post Survey
        // Q#Item == Single question being added to the post survey form
        let postQ1Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q1", text: QTC[0].text, answerFormat: QAF)
        let postQ2Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q2", text: QTC[1].text, answerFormat: QAF)
        let postQ3Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q3", text: QTC[2].text, answerFormat: QAF)
        let postQ4Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q4", text: QTC[3].text, answerFormat: QAF)
        let postQ5Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q5", text: QTC[4].text, answerFormat: QAF)
        let postQ6Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q6", text: QTC[5].text, answerFormat: QAF)
        let postQ7Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q7", text: QTC[6].text, answerFormat: QAF)
        let postQ8Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q8", text: QTC[7].text, answerFormat: QAF)
        let postQ9Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q9", text: QTC[8].text, answerFormat: QAF)
        let postQ10Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q10", text: QTC[9].text, answerFormat: QAF)
        let postQ11Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q11", text: QTC[10].text, answerFormat: QAF)
        let postQ12Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q12", text: QTC[11].text, answerFormat: QAF)
        let postQ13Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q13", text: QTC[12].text, answerFormat: QAF)
        let postQ14Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q14", text: QTC[13].text, answerFormat: QAF)
        let postQ15Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q15", text: QTC[14].text, answerFormat: QAF)
        let postQ16Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q16", text: QTC[15].text, answerFormat: QAF)
        let postQ17Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q17", text: QTC[16].text, answerFormat: QAF)
        let postQ18Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q18", text: QTC[17].text, answerFormat: QAF)
        let postQ191Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q19", text: QTC[18].text, answerFormat: QAF)
        let postQ20Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q20", text: QTC[19].text, answerFormat: QAF)
        
        // allPostQuestionItem == [ORKFormItem] that will be put into an ORKFormStep for the PostSurvey
        allPostQuestionItem += [postQ1Item, postQ2Item, postQ3Item, postQ4Item, postQ5Item, postQ6Item, postQ7Item, postQ8Item, postQ9Item, postQ10Item, postQ11Item, postQ12Item, postQ13Item, postQ14Item, postQ15Item, postQ16Item, postQ17Item, postQ18Item, postQ191Item, postQ20Item]
        
        
        let postFormStep = ORKFormStep(identifier: "\(K.TaskIDs.checkInTaskID).postSurvey.form", title: "postSurvey Step", text: "This is the PostSurvey ORKFormStep")
        postFormStep.isOptional = true
        postFormStep.formItems = allPostQuestionItem
        

        // MARK: ✅ ORKStep 5 of 5: ORKCompletionStep
        let completionStep = ORKCompletionStep(identifier: "\(K.TaskIDs.checkInTaskID).completionStep")
        completionStep.title = "Congratulations!"
        completionStep.detailText = "You have just completed 1 of 3 daily tasks."
        
        // surveyTask == a subclass of ORKTask required to be returned by func
        let surveyTask = ORKOrderedTask(identifier: K.TaskIDs.checkInTaskID,
                                        steps: [instructionStep,
                                                preFormStep,
                                                audioStep,
                                                postFormStep,
                                                completionStep])
        
        return surveyTask
    }
    
    
}
