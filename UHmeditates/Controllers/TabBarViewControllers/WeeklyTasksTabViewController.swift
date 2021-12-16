//
//  WeeklyTasksTabViewController.swift
//  UHmeditates
//
//  Created by Chase Philip on 1/25/21.
//STATUS: 🟢 == Fully Functioning, 🟡 == Useable State but not complete, 🔴 == Not functioning
/// ⚠️ == Missing Component
/// 🔶 == Question
/// ✅ == Part Completed
/// ❌ == Part Incomplete

// Can't figure out why i can't add them as reference outlets to modify their properties 

import UIKit
import Firebase
import FirebaseAuth
import ResearchKit

class WeeklyTasksTabViewController: UIViewController, ORKTaskViewControllerDelegate {
    
    // MARK: Variables that'll potentially be stored as UserDefaults
    var isOnboardingComplete = false
    var surveysCompleteToDate = 4
    
    
    // MARK: Button outlets
    @IBOutlet weak var buttonOneO: UIButton!
    @IBOutlet weak var buttonTwoO: UIButton!
    @IBOutlet weak var buttonThreeO: UIButton!
    
    // MARK: ORKTaskVC Dismiss
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        
        let userID = Auth.auth().currentUser?.uid
        var docTitle = "SurveyNum" + "\(surveysCompleteToDate)"
        
        TaskComponents.verifyDocExist(docTitle: docTitle) { doesExist in
            if doesExist == false {
                print(docTitle)
                
                TaskComponents.createDoc(docTitle: docTitle)
                
                let preResults: [ORKChoiceQuestionResult] = (taskViewController.result.results![1] as! ORKStepResult).results as! [ORKChoiceQuestionResult]
                
                // Loop of assigning pre results ID and answer values
                for result in preResults {
                    var resultIdentifier = "\(result.identifier)"
                    var resultValue = "\(result.answer ?? "null")"
                    
                    // Storing the answers in a looped process
                    TaskComponents.storeCheckInPreSurveyResults(docTitle: docTitle, resultID: resultIdentifier, resultValue: resultValue)
                }
                
                let postResults: [ORKChoiceQuestionResult] = (taskViewController.result.results![3] as! ORKStepResult).results as! [ORKChoiceQuestionResult]
                for result in postResults {
                    
                    var resultIdentifier = "\(result.identifier)"
                    var resultValue = "\(result.answer ?? "null")"
                    
                    TaskComponents.storeCheckInPostSurveyResults(docTitle: docTitle, resultID: resultIdentifier, resultValue: resultValue, user: userID!, start: "\(taskViewController.result.startDate)", end: "\(taskViewController.result.endDate)")
                }
            } else {
                print("Does exist, no write made to db")
            }
        }
//       if TaskComponents.verifyDocExist(docTitle: docTitle, completion: (Bool) -> Void) {
//
//            print(docTitle)
//
//            let preResults: [ORKChoiceQuestionResult] = (taskViewController.result.results![1] as! ORKStepResult).results as! [ORKChoiceQuestionResult]
//            // Loop of assigning pre results ID and answer values
//            for result in preResults {
//                var resultIdentifier = "\(result.identifier)"
//                var resultValue = "\(result.answer ?? "null")"
//
//                // Storing the answers in a looped process
//                TaskComponents.storeCheckInPreSurveyResults(docTitle: "SurveyNum" + "\(surveysCompleteToDate + 1)", resultID: resultIdentifier, resultValue: resultValue)
//            }
//
//            let postResults: [ORKChoiceQuestionResult] = (taskViewController.result.results![3] as! ORKStepResult).results as! [ORKChoiceQuestionResult]
//            for result in postResults {
//
//                var resultIdentifier = "\(result.identifier)"
//                var resultValue = "\(result.answer ?? "null")"
//
//                TaskComponents.storeCheckInPostSurveyResults(docTitle: docTitle, resultID: resultIdentifier, resultValue: resultValue, user: userID!, start: "\(taskViewController.result.startDate)", end: "\(taskViewController.result.endDate)")
//            }
//
//        } else if TaskComponents.verifyDocExist(docTitle: docTitle, completion: (Bool) -> Void) {
//            print("Document already exists, results will not be saved")
//
//        } else {
//            print("Verify doc didn't return an actual string ")
//        }
       
        
        if taskViewController.result.results != nil {
            //surveysCompleteToDate += 1
            print("Not Nil, meaning results do exist")
        }
        
        taskViewController.dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: Code Needing to Run when view loads
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // MARK: Insert Fxn here for checking document
        
        // MARK: Insert Fxn here for modifying button visibility
    }
    
    // MARK: Button Actions
    @IBAction func buttonOneAction(_ sender: UIButton) {
        
        let taskViewController = ORKTaskViewController(task: TaskComponents.showCheckInSurveyTask(), taskRun: nil)
        
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func buttonTwoAction(_ sender: UIButton) {
    
    }
    
    @IBAction func buttonThreeAction(_ sender: UIButton) {
        
    }
    
    // MARK: Logic for Buttons
    
    func codeForFindingOnboardingDoc (){
        // listener code for the document
        
        // if found, set isOnboardingComplete = true
        // if not found, set isOnboardingComplete = false
    }
    
    func setupDashboard () {
        // MARK: STATUS: 🔴
        
        if isOnboardingComplete == false {
            // ⚠️ : Hide all survey button elements
            buttonOneO.setTitle("testing Button", for: .normal)
            
        } else {
            // ⚠️ : Show user instructions and onboarding button
            
        }
        
    }
    
    func setupHomeScreen () {
        // MARK: STATUS: 🔴
        
        // ⚠️ : Hide all user instructions and onboarding button
        
        // ⚠️ : Show all survey button elements
    }
    
}
