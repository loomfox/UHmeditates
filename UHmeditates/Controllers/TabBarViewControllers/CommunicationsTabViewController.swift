//
//  CommunicationsTabViewController.swift
//  UHmeditates
//
//  Created by Chase Philip on 1/25/21.
//

import UIKit
import MessageUI
import ResearchKit
import Firebase

class CommunicationsTabViewController: UIViewController {

    func transitionToScreenAfterLaunch() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let mainTabBarController = storyboard.instantiateViewController(identifier: "ScreenAfterLaunch")
               (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
    }
    let mailButton = UIButton()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupButton()
            
            userLoggedIn.text = SignUpViewController().currentUser
        }
        
    @IBAction func userTappedSignOut(_ sender: UIBarButtonItem) {
        
        
        let firebaseAuth = Auth.auth()
        do {
            
          try firebaseAuth.signOut()
            transitionToScreenAfterLaunch()
        
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
    @IBOutlet weak var userLoggedIn: UILabel!
    
    
    
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
            print("Hi. hello;")
            guard MFMailComposeViewController.canSendMail() else {
                return
            }
            let composer = MFMailComposeViewController()
            composer.mailComposeDelegate = self
            composer.setToRecipients(["piyamalhan@gmail.com"])
            composer.setSubject("Hey there!")
            composer.setMessageBody("Hi, I'd like to know ", isHTML: false)
            self.present(composer, animated: true, completion: nil)
        }
    
    @IBAction func withdrawFromStudy(_ sender: UIButton) {
        
        let taskViewController = ORKTaskViewController(task: TaskComponents.withdraw(), taskRun: nil)
        present(taskViewController, animated: true, completion: nil)
    }
}

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
