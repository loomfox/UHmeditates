//
//  Constants.swift
//  UHmeditates
//
//  Created by Piya Malhan on 2/18/21.
//
// Edited 8/15 by Tyler during merge attempt main <- featurebranch

import Foundation
import ResearchKit
struct K {
    
    //MARK: Storyboard Constants
    struct Storyboard{
        static let homeViewController = "HomeVC"
        static let checkInController = "checkin"
    }
    
    //MARK: MeditationQuiz Constants
    struct KMeditationQuiz {
        
        let answerArray: [String] = ["Very slightly or not at all", "A little", "Moderately", "Quite a bit", "Extremely"]
    }
    
    struct TaskIDs {
        static let onboarding = "onboarding"
        static let checkIn = "checkin"
        
        private init() {}
    }
}



