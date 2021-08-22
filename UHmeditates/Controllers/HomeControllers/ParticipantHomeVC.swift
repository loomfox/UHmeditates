//
//  ParticipantHomeVC.swift
//  UHmeditates
//
//  Created by Tyler Boston on 8/20/21.
//

import UIKit
import CareKit
import CareKitStore
import CareKitUI

class ParticipantHomeVC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewController = OCKDailyTasksPageViewController(storeManager: AppDelegate().storeManager)
        navigationController?.pushViewController(viewController, animated: false)
        
        //        let todaysSurveyCard = SurveyViewController(taskID: "PreSurvey.form", eventQuery: OCKEventQuery(for:Date()), storeManager: AppDelegate().storeManager)
        //
        //        present(todaysSurveyCard, animated: true, completion: nil)
    }
    
        
    
    
    
}
