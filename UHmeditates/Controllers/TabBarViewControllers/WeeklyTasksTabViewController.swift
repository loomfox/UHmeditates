//
//  WeeklyTasksTabViewController.swift
//  UHmeditates
//
//  Created by Chase Philip on 1/25/21.
//

import UIKit
import Firebase
import FirebaseAuth
import ResearchKit

class WeeklyTasksTabViewController: UIViewController, ORKTaskViewControllerDelegate {
    var isOnboardingComplete = false
    
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
       
        let userID = Auth.auth().currentUser?.uid
        
        // once here, then I can navigate the heirarchy in console
            // po taskViewController.result.startDate (time when the task started)
            // po taskViewController.result.endDate (time when the task ends)
        // for checking the postSurvey, I think I can do po taskViewController.result.results! and see whats in this array
        
        let preResults: [ORKChoiceQuestionResult] = (taskViewController.result.results![1] as! ORKStepResult).results as! [ORKChoiceQuestionResult]
        for result in preResults {
            var resultIdentifier = "\(result.identifier)"
            var resultValue = "\(result.answer ?? "null")"
           
            TaskComponents.storeCheckInPreSurveyResults(resultID: resultIdentifier, resultValue: resultValue)
        }
        
        let postResults: [ORKChoiceQuestionResult] = (taskViewController.result.results![3] as! ORKStepResult).results as! [ORKChoiceQuestionResult]
        for result in postResults {
            
            var resultIdentifier = "\(result.identifier)"
            var resultValue = "\(result.answer ?? "null")"
           
            TaskComponents.storeCheckInPostSurveyResults(resultID: resultIdentifier, resultValue: resultValue, user: userID!, start: "\(taskViewController.result.startDate)", end: "\(taskViewController.result.endDate)")
        }
        taskViewController.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    //MARK: Logic for Buttons
    
    func codeForFindingOnboardingDoc (){
        // listener code for the document
        
        // if found, set isOnboardingComplete = true
        // if not found, set isOnboardingComplete = false
    }
    
    func setupDashboard () {
        
        if isOnboardingComplete == false {
            // hide all survey button elements
        
        } else {
            // show user instructions and onboarding button
            
        }
        
    }
    
    func setupHomeScreen () {
        // hide all user instructions and onboarding button
        
        // show all survey button elements
    }
    
    // MARK: Buttons
    @IBAction func firstButton(_ sender: UIButton) {
        
        let taskViewController = ORKTaskViewController(task: TaskComponents.showCheckInSurveyTask(), taskRun: nil)
        
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func secondButton(_ sender: UIButton) {
        
        TaskComponents.showCheckInSurveyTask()
        
    }
    
    @IBAction func thirdButton(_ sender: UIButton) {
        TaskComponents.showCheckInSurveyTask()
        
    }
}
