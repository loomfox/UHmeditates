//
//  TestViewController.swift
//  UHmeditates
//
//  Created by Tyler Boston on 8/3/21.
//

import Foundation
import Firebase
import ResearchKit

class TestViewController: UIViewController, ORKTaskViewControllerDelegate {
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        taskViewController.dismiss(animated: true, completion: nil)

    }
    
    
    @IBOutlet weak var ConsentButton: UIButton!
    
    @IBOutlet weak var SurveyButton: UIButton!
    
    @IBOutlet weak var ActionTaskButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func consentClicked(_ sender: UIButton) {
        let taskViewController = ORKTaskViewController(task: ConsentTask, taskRun: nil)
            taskViewController.delegate = self
            present(taskViewController, animated: true, completion: nil)
    }
    
    @IBAction func surveyClicked(_ sender: UIButton) {
       
//        SurveyTask().showForm()
        let taskViewController = ORKTaskViewController(task: showMeditationSurvey(), taskRun: nil); present(taskViewController, animated: true, completion: nil)
    }
    @IBAction func activeTaskClicked(_ sender: UIButton) {
       
    }
    
}
