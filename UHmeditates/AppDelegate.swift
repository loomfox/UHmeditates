//
//  AppDelegate.swift
//  UHmeditates
//
//  Created by Chase Philip on 1/25/21.
//

import UIKit
import Firebase
import ResearchKit
import CareKitStore
import CareKit
import CareKitUI
import CareKitFHIR
import os.log



@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let storeManager = OCKSynchronizedStoreManager(
        wrapping: OCKStore(
            name: "com.UHmeditates",
            type: .inMemory
        )
    )
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        let db = Firestore.firestore()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    
    //MARK: Seeding the CareKit Store
    
    private func seedTasks() {
        
        //1.1 Persist an onboarding task
        let onboardSchedule = OCKSchedule.dailyAtTime(hour: 0, minutes: 0, start: Date(), end: nil, text: "Task Due!" , duration: .allDay)
        
        var onboardTask = OCKTask(id: K.TaskIDs.onboarding, title: "Onboarding Task", carePlanUUID: nil, schedule: onboardSchedule)
        
        onboardTask.instructions = "Before getting started, let's review some terms and conditions!"
        onboardTask.impactsAdherence = false //means onboarding won't count to completion rings
        
        //1.1.1 Persist task into store
        storeManager.store.addAnyTasks([onboardTask], callbackQueue: .main) {
            result in switch result {
            case let .success(tasks): Logger.store.info("seeded \(tasks.count) tasks")
            case let .failure(error): Logger.store.info("Failed to see tasks: \(error as NSError)")
            }
        }
    }

}

