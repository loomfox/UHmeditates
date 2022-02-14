//
//  TaskComponents.swift
//  UHmeditates

// STATUS: 🟢 == Fully Functioning, 🟡 == Useable State but not complete, 🔴 == Not functioning
// ⚠️ == Missing Component
// 🔶 == Question
// ✅ == Part Completed
// ❌ == Part Incomplete

import ResearchKit
import Firebase
import FirebaseAuth
import FirebaseCore

struct CompletedSurveyItem: Identifiable {
    
    var id: String
    var endDate: String
    var surveyName: String
    
    
}

struct EnrollmentStatusStruct: Identifiable {
    
    var id: String
    var enrollmentStatus: String
    
}

struct RandomizationGroupStruct: Identifiable {
    
    var id: String
    var groupName: String
    
}

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
    
    let db = Firestore.firestore()
    
    static func transitionToScreenAfterLaunch() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "ScreenAfterLaunch")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        
    }
    // MARK: Modifying / Creating / Deleting User Docs
    static func signOutUser() {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            transitionToScreenAfterLaunch()
           
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            
            transitionToScreenAfterLaunch()
            // need to condense signOutUser, transitionToScreenAfterLaunch() & the IBOutlet of logOff()
        }
        
        // Code may be required when determining how to proceed with user data
//        user?.delete { error in
//            if let error = error {
//                print(error)
//            } else {
//                print("User has been deleted")
//                self.transitionToScreenAfterLaunch()
//            }
//
//        }
        
    }
    static func appendUserGroup (userUID: String, RandomizationGroup: String ) {
        let db = Firestore.firestore()
        let docRef = db.collection("AdministrativeDocs").document("UserGroups")
        
        docRef.setData([
            userUID: RandomizationGroup
        ], merge: true) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        
    }
    
    static func verifyUserGroup(userUID: String, completion: @escaping (RandomizationGroupStruct?) ->()) {
        //item is var groupName: String
        // reference to database
        let db = Firestore.firestore()
        let docRef = db.collection("AdministrativeDocs").document("UserGroups")
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let property = document.get("\(userUID)")
                
                completion(RandomizationGroupStruct(id: document.documentID, groupName: property as! String))
                
                
                // wont work trying to get a return value from inside a closure, refer to the article open in safari then work backward from this function to where it's called to determine the next step in handling the output. After that, sign out, and create a new user to test if the append function writes to the doc instead of deleting the previous user info.
                print(userUID)
                print("Document data: \(property!)")
            } else {
                print("Document does not exist")
            }
            
        }
    }
    
    // MARK: 💠 Functions for Reading Database 💠
    
    static func verifyDocExist(randomizationGroup: String, userUID: String, docTitle: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        
        let docRef = db
            .collection(randomizationGroup)
            .document(userUID)
            .collection("Docs for \(userUID)")
            .document(docTitle)
        
        docRef.getDocument { (doc, error) in
            if let doc = doc, doc.exists {
                completion(true)
            } else {
                completion(false)
            }
            
        }
        
    }
    
    // MARK: 💠 Functions for Database Modifications 💠
    /// NOTE: I need to get the reads and writes down, maybe for writes I could create an empty dictionary array and populate it with the items in the for loop and only upload the dictionary array?
    static func createDocCollection(docTitle: String) { // Used to create user folder for surveys during sign up
        
        let db = Firestore.firestore()
        db.collection("ControlGroup/"+docTitle).document("TestingCreation")
        
    }
    
    static func createDoc(randomizationGroup: String, userUID: String, docTitle: String) {

        let db = Firestore.firestore()
        db.collection(randomizationGroup).document(userUID).collection("Docs for \(userUID)").document(docTitle).setData(["Created" : docTitle ])
    }
    
    // MARK: 💠 Type of Tasks 💠
    
    static func showOnboardingSurvey() -> ORKTask {
        //MARK: STATUS: 🟢
        var onboardingSteps = [ORKStep]()
        
        // MARK: ✅ ORKStep 1 of 7: ORKInstructionStep
        let welcomeStep = ORKInstructionStep(identifier: "\(K.TaskIDs.onboardingTaskID).welcome")
        welcomeStep.title = "Welcome to UHMeditates!"
        welcomeStep.detailText = "Welcome to the study! By now, you should have already been able to read through the Informed Consent. If you haven’t don’t worry, we’re going to review it once more."
        welcomeStep.image = UIImage(named: "Happy") // ommit if no need to for image
        onboardingSteps += [welcomeStep]
        
        // MARK: ✅ ORKStep 2 of 7: ORKInstructionStep with ORKBodyItems
        let studyPurposeInstructionStep = ORKInstructionStep(identifier: "\(K.TaskIDs.onboardingTaskID).studyPurpose")
        studyPurposeInstructionStep.title = "Study Purpose"
        studyPurposeInstructionStep.image = UIImage(named: "Happy")
        onboardingSteps += [studyPurposeInstructionStep]
        
        let purposePointOne = ORKBodyItem(
            text: "This study aims to investigate the links between various meditation practices, ad social decision making. We hope that with your help, we can use games and biometric data to understand more about the biology of meditation and social decision making.",
            detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        studyPurposeInstructionStep.bodyItems = [purposePointOne]
        
        
        // MARK: ✅ ORKStep 3 of 7: ORKInstructionStep with ORKBodyItems
        let rightsAsParticipantInstructionStep = ORKInstructionStep(identifier: "\(K.TaskIDs.onboardingTaskID).rightsAsParticipant")
        rightsAsParticipantInstructionStep.title = "Overview of Your Rights as a Participant"
        rightsAsParticipantInstructionStep.image = UIImage(named: "Happy")
        onboardingSteps += [rightsAsParticipantInstructionStep]
        
        // pointOne-Five are in useable state and will be populated with the right content late for ORKStep 2 of 4
        let pointOne = ORKBodyItem(
            text: "Taking part in the research is voluntary; whether or not you decide to complete it to receive the SONA credit your choice.",
            detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        let pointTwo = ORKBodyItem(
            text: "You can agree to participate but if you decide to withdraw your participation later in the study, your decision will not be held against you and if you are a student, it will not in any way impact your grades at the University of Houston.",
            detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        let pointThree = ORKBodyItem(
            text: "If you have questions, you may visit the ‘Communications’ Tab, and email the Principal Investigators by pressing the 'Email Us!' button.",
            detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        let pointFour = ORKBodyItem(
            text: "The Principal Investigators for the study will be: Chase Philip, Guy Joseph, and Piya Malhan.",
            detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        rightsAsParticipantInstructionStep.bodyItems = [pointOne, pointTwo, pointThree, pointFour]
        
        // MARK: ✅ ORKStep 3 of 6: ORKInstructionStep with ORKBodyItems
        let roleAsParticipantInstructionStep = ORKInstructionStep(identifier: "\(K.TaskIDs.onboardingTaskID).roleAsParticipant")
        roleAsParticipantInstructionStep.title = "Overview of Your Role as a Participant"
        roleAsParticipantInstructionStep.image = UIImage(named: "Happy")
        onboardingSteps += [roleAsParticipantInstructionStep]
        
        // pointOne-Five are in useable state and will be populated with the right content late for ORKStep 2 of 4
        let roleAsPointOne = ORKBodyItem(
            text: "Playing a short video game.",
            detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        let roleAsPointTwo = ORKBodyItem(
            text: "Completing 3 meditations or 'Check-In Surveys' a week by starting a new survey on the 'Dashboard' tab.",
            detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        let roleAsPointThree = ORKBodyItem(
            text: "Completing several questionnaires that cover these concepts: personality, mindfulness, gratitude, depression/anxiety/stress, and present emotions. You have the right to skip any questions that may make you feel uncomfortable.",
            detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        let roleAsPointFour = ORKBodyItem(
            text: "For each meditation completed, you will accrue 1-point that be used as tickets for a weekly raffle for a $20 Amazon gift card.",
            detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        let roleAsPointFive = ORKBodyItem(
            text: "Data on your heart rate will be collected throughout. Heart rate data will either be directly collected (if the individual has a smartwatch capable) or through constant streaming of HR Data.", detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        roleAsParticipantInstructionStep.bodyItems = [roleAsPointOne, roleAsPointTwo, roleAsPointThree, roleAsPointFour, roleAsPointFive]
        // MARK: ✅ ORKStep 4 of 6: ORKInstructionStep with ORKBodyItems
        let studyOverViewInstructionStep = ORKInstructionStep(identifier: "\(K.TaskIDs.onboardingTaskID).overview")
        studyOverViewInstructionStep.title = "Overview"
        studyOverViewInstructionStep.image = UIImage(named: "Happy")
        onboardingSteps += [studyOverViewInstructionStep]
        
        // pointOne-Five are in useable state and will be populated with the right content late for ORKStep 2 of 4
        let overviewPointOne = ORKBodyItem(
            text: "Heart rate data will be collected through a compatible heart rate monitor device.", detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        let overviewPointTwo = ORKBodyItem(
            text: "If possible, please keep the device worn throughout the day.", detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        let overviewPointThree = ORKBodyItem(
            text: "The Individual in possession of the device is responsible for any loss or damages to the device.", detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        let overviewPointFour = ORKBodyItem(
            text: "If the device is lost or damaged, the individual in possession of it is responsible for paying a 120$ fine", detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        studyOverViewInstructionStep.bodyItems = [overviewPointOne, overviewPointTwo, overviewPointThree, overviewPointFour]
        
//        // MARK: ✅ ORKStep 5 of 6: ORKRequestPermissionsStep
//        let notificationPermisisonType = ORKNotificationPermissionType(authorizationOptions: [.alert, .badge, .sound])
//        let requestPermissionStep = ORKRequestPermissionsStep(identifier: "\(K.TaskIDs.onboardingTaskID).permissionRequestStep", permissionTypes: [notificationPermisisonType])
//        onboardingSteps += [requestPermissionStep]
        
        // MARK: ✅ ORKStep 6 of 6: ORKCompletionStep
        let completionStep = ORKCompletionStep(identifier: "\(K.TaskIDs.onboardingTaskID).completion")
        completionStep.title = "Thanks for joining the study!"
        completionStep.detailText = "You are now ready to access the rest of the app!"
        onboardingSteps += [completionStep]
        
        // MARK: Last Step for Completion of IntroductionSurvey
        let surveyTask = ORKOrderedTask(identifier: K.TaskIDs.onboardingTaskID, steps: onboardingSteps)
        return surveyTask
    }
    
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
            ORKTextChoice(text: K.CheckInSurveyTask().answerArray[4], value: 4 as NSNumber),
            ORKTextChoice(text: K.CheckInSurveyTask().answerArray[5], value: 5 as NSNumber)
        ]
        
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
        preQ1Item.showsProgress = true
        let preQ2Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q2", text: QTC[1].text, answerFormat: QAF)
        preQ2Item.showsProgress = true
        let preQ3Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).preSurvey.form.Q3", text: QTC[2].text, answerFormat: QAF)
        preQ3Item.showsProgress = false
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
        
        // MARK: ❌ ORKStep 3 of 5: ORKVideoInstructionStep
        
        /// The function works for presenting a video, now we just need to load in all the meditations and manage the rules for using the commented out switch case for determining which url video will be passed in depending on the check-in survey # or however we can figure out distinguishing it; maybe by the variables associated with the progress bar will work.
        
        // create bundle path pointing to the file
        let bundlePath = Bundle.main.path(forResource: "SyedMeditation", ofType: "mp4")
        
        // creating the url
        let url = URL(fileURLWithPath: bundlePath!)
        
        //        switch url {
        //        case "Meditation Task 1/3" : "Then Load this Specific Video File / URL"
        //        case "Meditation Task 2/3" : "Then Load this Specific Video File / URL"
        //        case "Meditation Task 3/3" : "Then Load this Specific Video File / URL"
        //        default: "Error Message: Video obviously didn't load"
        //        }
        
        let meditationVideoStep = ORKVideoInstructionStep(identifier: "\(K.TaskIDs.checkInTaskID).meditationAudio")
        meditationVideoStep.title = "This is an Audio Step"
        meditationVideoStep.detailText = "This hasn't been implemented fully yet, but should feature a preloaded meditation audio based on the week / task"
        meditationVideoStep.isOptional = true
        meditationVideoStep.videoURL = url
        meditationVideoStep.thumbnailTime = 0
        
        // MARK: ✅ ORKStep 4 of 5: ORKFormStep for Post Survey
        // Q#Item == Single question being added to the post survey form
        let postQ1Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).postSurvey.form.Q1", text: QTC[0].text, answerFormat: QAF)
        let postQ2Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).postSurvey.form.Q2", text: QTC[1].text, answerFormat: QAF)
        let postQ3Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).postSurvey.form.Q3", text: QTC[2].text, answerFormat: QAF)
        let postQ4Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).postSurvey.form.Q4", text: QTC[3].text, answerFormat: QAF)
        let postQ5Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).postSurvey.form.Q5", text: QTC[4].text, answerFormat: QAF)
        let postQ6Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).postSurvey.form.Q6", text: QTC[5].text, answerFormat: QAF)
        let postQ7Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).postSurvey.form.Q7", text: QTC[6].text, answerFormat: QAF)
        let postQ8Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).postSurvey.form.Q8", text: QTC[7].text, answerFormat: QAF)
        let postQ9Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).postSurvey.form.Q9", text: QTC[8].text, answerFormat: QAF)
        let postQ10Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).postSurvey.form.Q10", text: QTC[9].text, answerFormat: QAF)
        let postQ11Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).postSurvey.form.Q11", text: QTC[10].text, answerFormat: QAF)
        let postQ12Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).postSurvey.form.Q12", text: QTC[11].text, answerFormat: QAF)
        let postQ13Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).postSurvey.form.Q13", text: QTC[12].text, answerFormat: QAF)
        let postQ14Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).postSurvey.form.Q14", text: QTC[13].text, answerFormat: QAF)
        let postQ15Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).postSurvey.form.Q15", text: QTC[14].text, answerFormat: QAF)
        let postQ16Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).postSurvey.form.Q16", text: QTC[15].text, answerFormat: QAF)
        let postQ17Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).postSurvey.form.Q17", text: QTC[16].text, answerFormat: QAF)
        let postQ18Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).postSurvey.form.Q18", text: QTC[17].text, answerFormat: QAF)
        let postQ191Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).postSurvey.form.Q19", text: QTC[18].text, answerFormat: QAF)
        let postQ20Item = ORKFormItem(identifier: "\(K.TaskIDs.checkInTaskID).postSurvey.form.Q20", text: QTC[19].text, answerFormat: QAF)
        
        // allPostQuestionItem == [ORKFormItem] that will be put into an ORKFormStep for the PostSurvey
        allPostQuestionItem += [postQ1Item, postQ2Item, postQ3Item, postQ4Item, postQ5Item, postQ6Item, postQ7Item, postQ8Item, postQ9Item, postQ10Item, postQ11Item, postQ12Item, postQ13Item, postQ14Item, postQ15Item, postQ16Item, postQ17Item, postQ18Item, postQ191Item, postQ20Item]
        
        
        let postFormStep = ORKFormStep(identifier: "\(K.TaskIDs.checkInTaskID).postSurvey.form", title: "postSurvey Step", text: "This is the PostSurvey ORKFormStep")
        postFormStep.isOptional = true
        postFormStep.formItems = allPostQuestionItem
        
        
        // MARK: ✅ ORKStep 5 of 5: ORKCompletionStep
        let completionStep = ORKCompletionStep(identifier: "\(K.TaskIDs.checkInTaskID).completionStep")
        completionStep.title = "Congratulations!"
        completionStep.detailText = "You have completed 1 of 3 weekly tasks."
        
        // surveyTask == a subclass of ORKTask required to be returned by func
        let surveyTask = ORKOrderedTask(identifier: K.TaskIDs.checkInTaskID,
                                        steps: [instructionStep, //0
                                                preFormStep, //1
                                                meditationVideoStep, //2
                                                postFormStep, //3
                                                completionStep]) //4
        surveyTask.progressLabelColor = .red
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
    
    static func showWithdrawSurvey() -> ORKTask {
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
            text: "By selecting to withdraw from the study,  you have agreed to no longer participate. Please note that withdrawing from the study will not have an effect on your grades or standing with the University of Houston. ", detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        let pointTwo = ORKBodyItem(
            text: "You may not be entitled to the benefits of the study dependent upon the amount completed.", detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        let pointThree = ORKBodyItem(
            text: "If you choose, all data collected from your person will be deleted. ", detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        let pointFour = ORKBodyItem(
            text: "We would appreciate it if we were allowed to use the data collected for the sole purpose of this research study.", detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        let pointFive = ORKBodyItem(
            text: "5. Details about the withdrawal protocol", detailText: nil,
            image: UIImage(systemName: "clock.badge.checkmark"),
            learnMoreItem: nil,
            bodyItemStyle: .bulletPoint, useCardStyle: true)
        
        // MARK: ✅ ORKStep 3 of 4: ORK
        secondInformativeStep.bodyItems = [pointOne, pointTwo, pointThree, pointFour, /*pointFive*/]
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
    
    // MARK: 💠 Storing Task Results 💠
    
    static func storeCheckInPreSurveyResults(randomizationGroup: String, userUID: String, docTitle: String, resultID: String, resultValue: String) {
        
        // MARK: STATUS 🟡

        let db = Firestore.firestore()
        let docRef = db
            .collection(randomizationGroup)
            .document(userUID)
            .collection("Docs for \(userUID)")
            .document(docTitle)
       
        // Capture results
        docRef.updateData([resultID : resultValue])
      
       // print(resultID + "& \(resultValue)")
       
    }
    
    static func  storeCheckInPostSurveyResults(randomizationGroup: String, userUID: String, docTitle: String, resultID: String, resultValue: String, start: String, end: String) {
        
            /// I believe these storage functions will be a general start in the right direction for storing the captured results from the specified ORKTask.
            
            let db = Firestore.firestore()
            let docRef = db
                .collection(randomizationGroup)
                .document(userUID)
                .collection("Docs for \(userUID)")
                .document(docTitle)
            
            print("Arrived at storeWithdrawTaskResults(), shoould have data")
        // MARK: STATUS 🟡

        // Capture results
       docRef.updateData(["Task Start:" : start,
                                           "Task End:" : end,
                                           "User Logged In:" : userUID,
                                           "\(resultID)" : "\(resultValue)"])
        
       // print("\(resultID) - \(resultValue)")
       
    }
    
    static func  storeOffboardingTaskResults() {
        // MARK: STATUS 🟡
        /// I believe these storage functions will be a general start in the right direction for storing the captured results from the specified ORKTask.
        
        let db = Firestore.firestore()
        let tempStorageDestination = db.collection("users").document("TestFeedbackStorage")
        // Uncomment below code once the data can be captured in the required format of [String:Any]
        // tempStorageDestination.setData([String : Any])
        
        // In final product, this is ideally how storing the results should be
        let idealStorageDestination = db
            .collection("users").document("usersUniqueIDObject")
            .collection("OffboardingSurveyFeedbackResults").document("FeedbackResults") // in the form of [FeedbackQuestion:usersText]
        
    }
    
    static func  storeWithdrawTaskResults(randomizationGroup: String, userUID: String, docTitle: String, resultID: String, resultValue: String) {
        // MARK: STATUS 🟡
        /// I believe these storage functions will be a general start in the right direction for storing the captured results from the specified ORKTask.
        
        let db = Firestore.firestore()
        let docRef = db
            .collection(randomizationGroup)
            .document(userUID)
            .collection("Docs for \(userUID)")
            .document(docTitle)
        
        docRef.setData(["SurveyName" : docTitle,
                      resultID : resultValue])
        
        let docRef2 = db
            .collection(randomizationGroup)
            .document(userUID)
        
        docRef2.updateData(["EnrollmentStatus" : "Withdrawn"])
        //print("Arrived at storeWithdrawTaskResults(), shoould have data")
        
    }
}
