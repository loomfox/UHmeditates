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

import AVKit


class TestingTaskAccessTabViewController: UIViewController, ORKTaskViewControllerDelegate {
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
       
        
//        if Auth.auth().currentUser != nil {
//            // user is logged in
//            var UserLoggedIn = Auth.auth().currentUser?.uid
//        } else {
//            // user is not logged in
//            var UserLoggedIn = "No one is logged in: \(Auth.auth().currentUser?.uid)"
//        }
        let userID = Auth.auth().currentUser?.uid
        
        print("Here")
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
           
            TaskComponents.storeCheckInPostSurveyResults(resultID: resultIdentifier, resultValue: resultValue, user: userID!)
        }
        taskViewController.dismiss(animated: true, completion: nil)
    }
    
    
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()
    
    //let db = Firestore.firestore()
    
    
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
    
    @IBAction func abutton(_ sender: UIButton) { audioPlayer.play()
        
        func preparePlayer() {
            guard let url = URL(string: "gs://uhmed-318b3.appspot.com/Meliza_one minute centering meditation.m4a") else {
                print("Invalid URL")
                return
            }
            do {
                let session = AVAudioSession.sharedInstance()
                try session.setCategory(AVAudioSession.Category.playback)
                let soundData = try Data(contentsOf: url)
                audioPlayer = try AVAudioPlayer(data: soundData)
                audioPlayer.volume = 1
                let minuteString = String(format: "%02d", (Int(audioPlayer.duration) / 60))
                let secondString = String(format: "%02d", (Int(audioPlayer.duration) % 60))
                print("TOTAL TIMER: \(minuteString):\(secondString)")
            } catch {
                print(error)
            }
        }
    }
}


