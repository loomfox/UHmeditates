//
//  CareFeedViewController.swift
//  UHmeditates
//
//  Created by Tyler Boston on 8/9/21.
//

import UIKit
import CareKit
import CareKitUI
import CareKitStore
import ResearchKit
import os.log

// MARK: New Code

///


class ParticipantFeedController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let manager = OCKSynchronizedStoreManager(
            wrapping: OCKStore(
                name: "my-store",
                type: .onDisk(protection: .none)))
//
        let careVC = OCKDailyTasksPageViewController(storeManager: manager)
//            careVC.self.storyboard?.instantiateViewController(identifier: "ParticipantTaskFeed")
//        self.definesPresentationContext = true
//        careVC.modalPresentationStyle = .overCurrentContext
        self.present(careVC, animated: true, completion: nil)
//
    }

    }
    
final class SurveyViewSynchronizer: OCKInstructionsTaskViewSynchronizer {

    override func updateView(
        _ view: OCKInstructionsTaskView,
        context: OCKSynchronizationContext<OCKTaskEvents>) {

        super.updateView(view, context: context)

        if let event = context.viewModel.first?.first, event.outcome != nil {
            view.instructionsLabel.isHidden = false
            
            // MARK: Question: Why do i need to have lines 171-175
            let pain = event.id

            view.instructionsLabel.text = """
                Pain: \(pain)
                """
        } else {
            view.instructionsLabel.isHidden = true
        }
    }
}
    // MARK: Step 1. Subclass Task View Controller for presenting RK Survey

    class SurveyViewController: OCKInstructionsTaskViewController, ORKTaskViewControllerDelegate {
        
        // MARK: Step 2. Create a method that is called when the user taps the button
        override func taskView(_ taskView: UIView & OCKTaskDisplayable, didCompleteEvent isComplete: Bool, at indexPath: IndexPath, sender: Any?) {
            /* Notes:
             // •
             */
            
            // MARK: Step 2A. If the task was marked incomplete, return to the super class's default behavior (offering the button) or delete the outcome
            if !isComplete {
                super.taskView(taskView, didCompleteEvent: isComplete, at: indexPath, sender: sender)
                
                return
            }
            
            // MARK: Step 2B. If User attempts to mark task complete, display a ResearchKit Survey
            let preSurveyViewController = ORKTaskViewController(task: TaskComponents.showCheckInSurveyTask(), taskRun: nil)
            preSurveyViewController.delegate = self
            
            //MARK: Step 2C. Present the pre-survey to the user
            present(preSurveyViewController, animated: true, completion: nil)
        }
        
        // MARK: Step 3: Implementing the required delegate method for class protocol compliance; method will be called when user completes survey
        func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
            taskViewController.dismiss(animated: true, completion: nil)
            guard reason == .completed else {
                taskView.completionButton.isSelected = false
                return
            }
            
            
            // MARK: Step 4. Retrieving the results
            /* Note:
             • This may fail because I'm not sure where to point surveyResults to grab the array of answers that would come out of an ORKFormStep since there are 20 items
             • I would hope that I could just grab the values for all of them at once w/ little code but I'm not sure yet.
             • The identifier may need to be replaced to "PreSurvey" instead
             • the ".first" in both surveyResults and questionOne may need to be removed
             • answer may not even return the values
             
             - Theories -
             1. 'answer' will print out gibberish
             2. line 72 will crash app due to gibberish
             */
            let surveyResults = taskViewController.result.results!.first(where: {$0.identifier == "PreSurvey.form" }) as! ORKStepResult
            let questionOne = surveyResults.results!.first as! ORKChoiceQuestionResult
            let answer = "\(questionOne.choiceAnswers!)"
            print(answer)
            
            controller.appendOutcomeValue(value: answer, at: IndexPath(item: 0, section: 0), completion: nil)
            
            
        }
    }

