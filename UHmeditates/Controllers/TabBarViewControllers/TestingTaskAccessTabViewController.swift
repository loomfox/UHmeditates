//
//  TestingTaskAccessTabViewController.swift
//  UHmeditates
//
//  Created by Piya Malhan on 2/23/21.
//

import UIKit

import FirebaseAuth
import Firebase
import FirebaseCore
import ResearchKit


class TestingTaskAccessTabViewController: UIViewController, ORKTaskViewControllerDelegate {
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
           
            TaskComponents.storeCheckInPreSurveyResults(docTitle: "test", resultID: resultIdentifier, resultValue: resultValue)
        }
        
        let postResults: [ORKChoiceQuestionResult] = (taskViewController.result.results![3] as! ORKStepResult).results as! [ORKChoiceQuestionResult]
        for result in postResults {
            
            var resultIdentifier = "\(result.identifier)"
            var resultValue = "\(result.answer ?? "null")"
           
            TaskComponents.storeCheckInPostSurveyResults(docTitle: "test", resultID: resultIdentifier, resultValue: resultValue, user: userID!, start: "\(taskViewController.result.startDate)", end: "\(taskViewController.result.endDate)")
        }
        taskViewController.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func onboardingTaskTapped(_ sender: UIButton) {
        
    
        
        let taskViewController = ORKTaskViewController(task: TaskComponents.showOnboardingSurvey(), taskRun: nil)
        
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
        
    
        
    }
    
    
    
    @IBAction func meditationTaskTapped(_ sender: UIButton) {
        let taskViewController = ORKTaskViewController(task: TaskComponents.showCheckInSurveyTask(), taskRun: nil)
        
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
        
    
    }
    
} 
