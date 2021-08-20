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
    
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    
}
