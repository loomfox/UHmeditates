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

/* The gist of what you need to do is...

1. Subclass an existing task view controller
2. Override the method that is called when the task is completed
3. Present a ResearchKit survey and wait for the user to complete it
4. Get the survey result and save it to CareKit's store

 Here is an example demonstrating how to prompt the user to rate their pain on a scale of 1-10.
Keep in mind as you're reading the code below that CareKit and ResearchKit both use the term "task", but that they are distinct.

// 1. Subclass a task view controller to customize the control flow and present a ResearchKit survey!
class SurveyViewController: OCKInstructionsTaskViewController, ORKTaskViewControllerDelegate {
        
    // 2. This method is called when the use taps the button!
    override func taskView(_ taskView: UIView & OCKTaskDisplayable, didCompleteEvent isComplete: Bool, at indexPath: IndexPath, sender: Any?) {
        
        // 2a. If the task was uncompleted, fall back on the super class's default behavior or deleting the outcome.
        if !isComplete {
            super.taskView(taskView, didCompleteEvent: isComplete, at: indexPath, sender: sender)
            return
        }
        
        // 2b. If the user attemped to mark the task complete, display a ResearchKit survey.
        let answerFormat = ORKAnswerFormat.scale(withMaximumValue: 10, minimumValue: 1, defaultValue: 5, step: 1, vertical: false,
                                                 maximumValueDescription: "Very painful", minimumValueDescription: "No pain")
        let painStep = ORKQuestionStep(identifier: "pain", title: "Pain Survey", question: "Rate your pain", answer: answerFormat)
        let surveyTask = ORKOrderedTask(identifier: "survey", steps: [painStep])
        let surveyViewController = ORKTaskViewController(task: surveyTask, taskRun: nil)
        surveyViewController.delegate = self

        present(surveyViewController, animated: true, completion: nil)
    }
    
    // 3. This method will be called when the user completes the survey.
    // Extract the result and save it to CareKit's store!
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        taskViewController.dismiss(animated: true, completion: nil)
        guard reason == .completed else {
            taskView.completionButton.isSelected = false
            return
        }
        
        // 4a. Retrieve the result from the ResearchKit survey
        let survey = taskViewController.result.results!.first(where: { $0.identifier == "pain" }) as! ORKStepResult
        let painResult = survey.results!.first as! ORKScaleQuestionResult
        let answer = Int(truncating: painResult.scaleAnswer!)
        
        // 4b. Save the result into CareKit's store
        controller.appendOutcomeValue(withType: answer, at: IndexPath(item: 0, section: 0), completion: nil)
    }
}
Once you have defined this view controller, you can add it into your app as you would any other CareKit view controller!

let todaysSurveyCard = SurveyViewController(
    taskID: "survey",
    eventQuery: OCKEventQuery(for: Date()),
    storeManager: storeManager)

present(surveyCard, animated: true, completion: nil)
You may also decide that you want the view to update to display the result of your survey instead of the default values used by the superclass. To change that, you can implement your own view synchronizer.

class SurveyViewSynchronizer: OCKInstructionsTaskViewSynchronizer {
    
    // Customize the initial state of the view
    override func makeView() -> OCKInstructionsTaskView {
        let instructionsView = super.makeView()
        instructionsView.completionButton.label.text = "Start Survey"
        return instructionsView
    }
    
    // Customize how the view updates
    override func updateView(_ view: OCKInstructionsTaskView,
                             context: OCKSynchronizationContext<OCKTaskEvents?>) {
        super.updateView(view, context: context)
        
        // Check if an answer exists or not and set the detail label accordingly
        if let answer = context.viewModel?.firstEvent?.outcome?.values.first?.integerValue {
            view.headerView.detailLabel.text = "Pain Rating: \(answer)"
        } else {
            view.headerView.detailLabel.text = "Rate your pain on a scale of 1 to 10"
        }
    }
}
Now, when you create an instance of your SurveyViewController, you can pass in your custom view synchronizer to change how the view updates.

let surveyCard = SurveyViewController(
    viewSynchronizer: SurveyViewSynchronizer(),
    taskID: "survey",
    eventQuery: OCKEventQuery(date: Date()),
    storeManager: storeManager)

present(surveyCard, animated: true, completion: nil) */

// 1. Subclass a task view controller to customize the control flow and present a ResearchKit survey!
class SurveyViewController: OCKInstructionsTaskViewController, ORKTaskViewControllerDelegate {
        
    // 2. This method is called when the use taps the button!
    override func taskView(_ taskView: UIView & OCKTaskDisplayable, didCompleteEvent isComplete: Bool, at indexPath: IndexPath, sender: Any?) {
        
        // 2a. If the task was uncompleted, fall back on the super class's default behavior or deleting the outcome.
        
        if !isComplete {
            super.taskView(taskView, didCompleteEvent: isComplete, at: indexPath, sender: sender)
            return
        }
        
        // 2b. If the user attemped to mark the task complete, display a ResearchKit survey.
        
        let surveyViewController = ORKTaskViewController(task: Surveys.showMeditationSurvey(), taskRun: nil)
        surveyViewController.delegate = self
        // 3a
        present(surveyViewController, animated: true, completion: nil)
    }
    
    // 3b. This method will be called when the user completes the survey.
    // Extract the result and save it to CareKit's store!
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        taskViewController.dismiss(animated: true, completion: nil)
        guard reason == .completed else {
            taskView.completionButton.isSelected = false
            return
        }
        
        // 4a. Retrieve the result from the ResearchKit survey
        let survey = taskViewController.result.results!.first(where: { $0.identifier == "MeditationTask" }) as! ORKTaskResult
        let painResult = survey.results!.first as! ORKScaleQuestionResult
        let answer = Int(truncating: painResult.scaleAnswer!)
        
        // 4b. Save the result into CareKit's store
        controller.appendOutcomeValue(value: answer, at: IndexPath(item: 0, section: 0), completion: nil)
    }
}

class ParticipantTaskFeed: OCKDailyTasksPageViewController {
    // OCKDailyTasksPageViewController shows the calendar and feed
    
    override func dailyPageViewController(_ dailyPageViewController: OCKDailyPageViewController,
                                          
                                          //overriding this method to (called whenever user swipes to new date) which should inspect the date, determine what we want to show on the date and append the appropriate contend to the viewcontroller
                                          prepare listViewController: OCKListViewController,
                                          for date: Date) {
        
        //1.3 check if onboarding is complete
        checkIfOnboardingIsComplete{
            isOnboarded in
            //1.4 if it isn't, show an onboarding card
            guard isOnboarded else {
                return
            }
            //1.5 if it is
            
        }
        
    }
    
    // 1.2: Check if onboarding is complete
    // Queries for all outcomes associated with the Onboarding Task and when it returns
    
    private func checkIfOnboardingIsComplete(_ completion: @escaping (Bool) -> Void) {
        
        var query = OCKOutcomeQuery()
        query.taskIDs = [K.TaskIDs.onboarding]
        
        // Check to see outcomes
        storeManager.store.fetchAnyOutcomes(query: query, callbackQueue: .main) { result in switch result {
        
        case .failure: Logger.feed.error("Failed to fetch onboarding outcomes!")
            completion(false)
        //if it returns and there aren't any outcomes, means onboarding hasnt completed yet
        case let .success(outcomes): completion(!outcomes.isEmpty)
        }
        
        }
    }
    
}
