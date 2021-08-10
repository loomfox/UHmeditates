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

class CareFeedViewController: OCKDailyTasksPageViewController, OCKSurv  {
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
