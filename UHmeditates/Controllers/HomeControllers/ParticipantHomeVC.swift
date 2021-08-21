//
//  ParticipantHomeVC.swift
//  UHmeditates
//
//  Created by Tyler Boston on 8/20/21.
//

import UIKit
import CareKit

class ParticipantHomeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewController = OCKDailyTasksPageViewController(storeManager: AppDelegate().storeManager)
        navigationController?.pushViewController(viewController, animated: false)
        
    }
    
    
    
    
}
