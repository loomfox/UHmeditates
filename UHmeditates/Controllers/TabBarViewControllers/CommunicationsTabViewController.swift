//
//  CommunicationsTabViewController.swift
//  UHmeditates
//
//  Created by Chase Philip on 1/25/21.
// MARK: Key
// STATUS: 🟢 == Fully Functioning, 🟡 == Useable State but not complete, 🔴 == Not functioning
// ⚠️ == Missing Component
// 🔶 == Question
// ✅ == Part Completed
// ❌ == Part Incomplete

import UIKit
import MessageUI
import ResearchKit
import Firebase
import FirebaseAuth

class CommunicationsTabViewController: UIViewController, ORKTaskViewControllerDelegate {
    
    // MARK: 1.1 - IBOutlets
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userUID: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var withdrawButtonO: UIButton!
    
    // MARK: 1.2 - Top-Level Object
    let mailButton = UIButton()
    var userGroup = [RandomizationGroupStruct]()
    
    // MARK: 1.3 - Top-Level Functions
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        // MARK: STATUS: 🟡 -
        
        // MARK: ✅ - Write code for collecting and storing feedback
        let db = Firestore.firestore()
        let authDB = Auth.auth().currentUser?.uid
        let IPuserUID = "\(authDB!)"
        
        let docTitle = "Withdrawal Doc"
        
        // Layer 2: Verify the randomization group
        TaskComponents.verifyUserGroup(userUID: IPuserUID) { userGroup in
            if let userGroup = userGroup?.groupName {
                
                // layer 3: Randomization group verified, proceed into code that needs to run after finding group
                TaskComponents.verifyDocExist(randomizationGroup: userGroup, userUID: IPuserUID, docTitle: docTitle) { doesExist in
                    if doesExist == false {
                        print(docTitle)
                        
                        // Layer 4: Code dependent on layer 3
                        TaskComponents.createDoc(randomizationGroup: userGroup, userUID: IPuserUID, docTitle: docTitle)
                        
                        
                        // Could be used to condense createDoc & any store_() that uploads results for all surveys the
                        // This code block should go inside of the createDoc() and potentially have a switch case or just a simple if the results are there, then go ahead and also upload results; otherwise simply create the doc and exit the function
                        // Essentially this would move the creation of the doc and storage into layer 5, and an input parameter for the results would be added to the func to be handled if present
//                        if results != nil {
//
//                        } else {
//
//                        }
                        
                        let feedback: [ORKTextQuestionResult] = (taskViewController.result.results![2] as! ORKStepResult).results as! [ORKTextQuestionResult]
                        
                        // Loop of assigning pre results ID and answer values
                        for result in feedback {
                            
                            // Layer 5: Code dependent on layer 4
                            let resultIdentifier = "\(result.identifier)"
                            let resultValue = "\(result.answer ?? "null")"
                            
                            
                            // Storing the answers in a looped process
                            TaskComponents.storeWithdrawTaskResults(randomizationGroup: userGroup, userUID: IPuserUID, docTitle: docTitle, resultID: resultIdentifier, resultValue: resultValue)
                            print("Arrived at Layer 5 to store withdraw results ")
                           
                        }
                        
                        
                    }
                    else {
                        print("Does exist, no write made to db")
                    }
                }
                
            }
        }
 
        if taskViewController.result.results != nil {
            print("Not Nil, meaning results do exist")
            
        }
        
        taskViewController.dismiss(animated: true, completion: TaskComponents.signOutUser)
        //signOutUser()
    }

    func setupButton() {
        view.addSubview(mailButton)
        mailButton.backgroundColor = .systemBlue
        mailButton.addTarget(self, action: #selector(showMailComposer), for: .touchUpInside)
        mailButton.setTitle(NSLocalizedString("Email us", comment: ""), for: .normal)
        mailButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        mailButton.translatesAutoresizingMaskIntoConstraints = false
        mailButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mailButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        mailButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        mailButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    @objc func showMailComposer() {
        print("Hi! I'd like to get a little more information about: ")
        guard MFMailComposeViewController.canSendMail() else {
            return
        }
        let user = Auth.auth().currentUser
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["Chase.r.philip@gmail.com"])
        composer.setSubject("GTP: Inquiry from \(user!)") /* ❓ - Can user's uid be present in email headline? */
        composer.setMessageBody("Hi! I'd like to get a little more information about: ", isHTML: false)
        self.present(composer, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userLabel.layer.borderWidth = 1
        userUID.layer.borderWidth = 1
        userEmail.layer.borderWidth = 1
        userEmail.layer.borderColor = UIColor.black.cgColor
        
        
        setupButton()
        if let user = Auth.auth().currentUser {
            userLabel.text = "Current User: \(user.uid)"
            //            userUID.text = "User ID: \(user.uid)"
            userEmail.text = "User Email: \(user.email ?? "None")"
        }
        
        
    }
    
    // MARK: 1.4 - IBActions
    @IBAction func userTappedSignOut(_ sender: UIBarButtonItem) {
        // MARK: STATUS: 🟢
        TaskComponents.signOutUser()
    }
    
    @IBAction func withdrawFromStudy(_ sender: UIButton) {
        //MARK: STATUS: 🟡
        // All this code runs in a straight line without stopping
        
        // MARK: 1.4.3 - Create the alert (Separate into it's own method later)
        let alert = UIAlertController(title: "Warning: Withdrawal Notice", message: "You have selected to withdraw from the research study which will require you to _. By selecting 'I Understand' you are confirming that you understand proceeding will cancel your participation within the study and will thus require you to promptly return any research related devices.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "I Understand", style: UIAlertAction.Style.destructive, handler: {
            
            // 1.4.3.1 - Define the action of presenting the withdrawal survey to user
            action in
            let taskViewController = ORKTaskViewController(task: TaskComponents.showWithdrawSurvey(), taskRun: nil)
            taskViewController.delegate = self
            taskViewController.modalPresentationStyle = .fullScreen
            self.present(taskViewController, animated: true, completion: nil)
        }))
        
        // 1.4.3.2 - Define the action of dismissing alert view controller
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: {
            action in alert.dismiss(animated: true, completion: nil)
        }))
        
        // 1.4.4 - Show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
}
// MARK: 1.5 - Extension
extension CommunicationsTabViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            controller.dismiss(animated: true, completion: nil)
            return
        }
        switch result {
        case .cancelled:
            break
        case .failed:
            break
        case .saved:
            break
        case .sent:
            break
        }
        controller.dismiss(animated: true, completion: nil)
    }
}
