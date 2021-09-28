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
        
        // MARK: ✅ ORKStep 1 of 4: ORKInstructionStep
        let welcomeStep = ORKInstructionStep(identifier: "\(K.TaskIDs.onboardingTaskID).welcome")
        welcomeStep.title = "Welcome to UHMeditates!"
        welcomeStep.detailText = "Thanks for joining the study, tap next to learn more about your role in the app"
        welcomeStep.image = UIImage(named: "Happy") // ommit if no need to for image
        onboardingSteps += [welcomeStep]
        
        // MARK: ✅ ORKStep 2 of 4: ORKInstructionStep with ORKBodyItems
        let studyOverViewInstructionStep = ORKInstructionStep(identifier: "\(K.TaskIDs.onboardingTaskID).overview")
        studyOverViewInstructionStep.title = "Overview"
        studyOverViewInstructionStep.image = UIImage(named: "Happy")
        onboardingSteps += [studyOverViewInstructionStep]
        
        // pointOne-Five are in useable state and will be populated with the right content later.
        let pointOne = ORKBodyItem(
            text: "Probably should remind them of how their heart rate is collected and if need be, create another instruction step for rules/reminders}", detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        let pointTwo = ORKBodyItem(
            text: "Point for important information or further instruction", detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        let pointThree = ORKBodyItem(
            text: "Point for important information or further instruction", detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        let pointFour = ORKBodyItem(
            text: "Point for important information or further instruction", detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        let pointFive = ORKBodyItem(
            text: "Point for important information or further instruction", detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        studyOverViewInstructionStep.bodyItems = [pointOne, pointTwo, pointThree, pointFour, pointFive]
        
        // MARK: ✅ ORKStep 3 of 4: ORKRequestPermissionsStep
        let notificationPermisisonType = ORKNotificationPermissionType(authorizationOptions: [.alert, .badge, .sound])
        let requestPermissionStep = ORKRequestPermissionsStep(identifier: "\(K.TaskIDs.onboardingTaskID).permissionRequestStep", permissionTypes: [notificationPermisisonType])
        onboardingSteps += [requestPermissionStep]
        
        // MARK: ✅ ORKStep 4 of 4: ORKCompletionStep
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
    
    static func offboardingTask() -> ORKTask {
        //MARK: STATUS: 🟡
        var offboardingSteps = [ORKStep]()
        
        // MARK: 🔶 Question: How can we implement the firebase doc modification after the completion of the withdrawal task?
        
        // MARK: ✅ ORKStep 1 of 5: ORKInstructionStep
        let informativeStep = ORKInstructionStep(identifier: "\(K.TaskIDs.offboardingTaskID).welcome")
        informativeStep.title = "Template Title"
        informativeStep.detailText = "Template Detail"
        offboardingSteps += [informativeStep]
        
        // MARK: ✅ ORKStep 2 of 5: ORKInstructionStep with ORKBodyItems
        let secondInformativeStep = ORKInstructionStep(identifier: "\(K.TaskIDs.offboardingTaskID).overview")
        secondInformativeStep.title = "Overview"
        offboardingSteps += [secondInformativeStep]
        
        // pointOne-Five are in useable state and will be populated with the right content later.
        let pointOne = ORKBodyItem(
            text: "1. Details about the offboarding protocol", detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        let pointTwo = ORKBodyItem(
            text: "2. Details about the offboarding protocol", detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        let pointThree = ORKBodyItem(
            text: "3. Details about the offboarding protocol", detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        let pointFour = ORKBodyItem(
            text: "4. Details about the offboarding protocol", detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        let pointFive = ORKBodyItem(
            text: "5. Details about the offboarding protocol", detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        secondInformativeStep.bodyItems = [pointOne, pointTwo, pointThree, pointFour, pointFive]
        
        // MARK: ✅ ORKStep 3 of 5: ORKFormStep (This will be expanded later on)
        var allFeedbackItems = [ORKFormItem]()
        
        //Answer formats for feedback questions
        let Q1AF = ORKScaleAnswerFormat(maximumValue: 5, minimumValue: 0, defaultValue: 3, step: 1, vertical: false, maximumValueDescription: "Very difficult", minimumValueDescription: "Not difficult at all")
        let Q2AF = ORKTextAnswerFormat()
        Q2AF.multipleLines = true
        
        let Q3AF = ORKScaleAnswerFormat(maximumValue: 5, minimumValue: 0, defaultValue: 3, step: 1, vertical: false, maximumValueDescription: "Very Likely", minimumValueDescription: "Not Likely at All")
        let Q4AF = ORKTextAnswerFormat()
        Q4AF.multipleLines = true
        
        let feedbackQ1 = ORKFormItem(identifier: "\(K.TaskIDs.offboardingTaskID).feedbackForm.Q1", text: "How difficult was it to participate in this study?", answerFormat: Q1AF, optional: true)
        let feedbackQ2 = ORKFormItem(identifier: "\(K.TaskIDs.offboardingTaskID).feedbackForm.Q2", text: "Please provide any detail as to why you chose the previous answer.", answerFormat: Q2AF, optional: true)
        let feedbackQ3 = ORKFormItem(identifier: "\(K.TaskIDs.offboardingTaskID).feedbackForm.Q2", text: "How likely wouuld you be to join another if a mobile application component is offered in the future?", answerFormat: Q3AF, optional: true)
        let feedbackQ4 = ORKFormItem(identifier: "\(K.TaskIDs.offboardingTaskID).feedbackForm.Q4", text: "Please provide any detail as to why you chose the previous answer.", answerFormat: Q4AF, optional: true)
        allFeedbackItems += [feedbackQ1, feedbackQ2, feedbackQ3, feedbackQ4]
        
        let feedbackForm = ORKFormStep(identifier: "\(K.TaskIDs.offboardingTaskID).feedbackForm", title: "Feedback Form", text: "Please complete this form")
        feedbackForm.formItems = allFeedbackItems
        offboardingSteps += [feedbackForm]
        
        // MARK: ✅ ORKStep 4 of 5: ORKQuestionStep for Overall Feedback
        let QAF = ORKTextAnswerFormat()
        QAF.multipleLines = true
        
        let feedbackStep = ORKQuestionStep(identifier: "feedback", title: "Optional Feedback to Help the Study Team", question: "Please provide any feedback or reasoning as to why you are withdrawing from the study. This will help the study team aims to collect and address and feedback provided to help shape future versions of the project. ", answer: QAF)
        offboardingSteps += [feedbackStep]
        
        // MARK: ✅ ORKStep 5 of 5: ORKCompletionStep
        let completionStep = ORKCompletionStep(identifier: "\(K.TaskIDs.offboardingTaskID).completion")
        completionStep.title = "Thanks for participating in the study!"
        completionStep.detailText = "You may now delete the application and proceed with returning the Fitbit Device to the study team"
        offboardingSteps += [completionStep]
        
        // MARK: ✅ Last Part for Completion of Offboarding Process
        let surveyTask = ORKOrderedTask(identifier: K.TaskIDs.offboardingTaskID, steps: offboardingSteps)
        return surveyTask
    }
    
    static func withdraw() -> ORKTask {
        //MARK: STATUS: 🟡
        var withdrawalSteps = [ORKStep]()
        
        // MARK: 🔶 Question: How can we implement the firebase doc modification after the completion of the withdrawal task?
        
        // MARK: ✅ ORKStep 1 of 4: ORKInstructionStep
        let informativeStep = ORKInstructionStep(identifier: "\(K.TaskIDs.withdrawalTaskID).welcome")
        informativeStep.title = "Template Title"
        informativeStep.detailText = "Template Detail"
        informativeStep.image = UIImage(named: "Sad") // ommit if no need to for image
        withdrawalSteps += [informativeStep]
        
        // MARK: ✅ ORKStep 2 of 4: ORKInstructionStep with ORKBodyItems
        let secondInformativeStep = ORKInstructionStep(identifier: "\(K.TaskIDs.withdrawalTaskID).overview")
        secondInformativeStep.title = "Overview"
        secondInformativeStep.image = UIImage(named: "Sad")
        withdrawalSteps += [secondInformativeStep]
        
        // pointOne-Five are in useable state and will be populated with the right content later.
        let pointOne = ORKBodyItem(
            text: "1. Details about the withdrawal protocol", detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        let pointTwo = ORKBodyItem(
            text: "2. Details about the withdrawal protocol", detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        let pointThree = ORKBodyItem(
            text: "3. Details about the withdrawal protocol", detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        let pointFour = ORKBodyItem(
            text: "4. Details about the withdrawal protocol", detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        let pointFive = ORKBodyItem(
            text: "5. Details about the withdrawal protocol", detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        // MARK: ✅ ORKStep 3 of 4: ORK
        secondInformativeStep.bodyItems = [pointOne, pointTwo, pointThree, pointFour, pointFive]
        let QAF = ORKTextAnswerFormat()
        QAF.multipleLines = true
        
        // MARK: ✅ ORKStep 4 of 5: ORKCompletionStep
        let feedbackStep = ORKQuestionStep(identifier: "feedback", title: "Optional Feedback to Help the Study Team", question: "Please provide any feedback or reasoning as to why you are withdrawing from the study. This will help the study team aims to collect and address and feedback provided to help shape future versions of the project. ", answer: QAF)
        withdrawalSteps += [feedbackStep]
        
        // MARK: ✅ ORKStep 5 of 5: ORKCompletionStep
        let completionStep = ORKCompletionStep(identifier: "\(K.TaskIDs.withdrawalTaskID).completion")
        completionStep.title = "Thanks for participating in the study!"
        completionStep.detailText = "You may now delete the application and proceed with returning the Fitbit Device to the study team"
        withdrawalSteps += [completionStep]
        
        // MARK: ✅ Last Step for Completion of Withdrawal Process
        let surveyTask = ORKOrderedTask(identifier: K.TaskIDs.withdrawalTaskID, steps: withdrawalSteps)
        return surveyTask
    }
    
}
