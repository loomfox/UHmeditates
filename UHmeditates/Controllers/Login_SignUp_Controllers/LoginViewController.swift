//
//  LoginViewController.swift
//  UHmeditates
//
//  Created by Chase Philip on 1/25/21.
//

import UIKit
import Firebase
import FirebaseAuth
import MessageUI

class LoginViewController: UIViewController {
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()

    }
    
    func setUpElements() {
        
        // Hide error label
        errorLabel.alpha = 0
    }
    
    @objc func showMailComposer() {
        guard MFMailComposeViewController.canSendMail() else {
            //show alert informing user they can't send mail
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["piyamalhan@gmail.com"])
        composer.setSubject("Hey there!")
        composer.setMessageBody("Hi, I'm currently facing issues with logging into the application.", isHTML: false)
        present(composer, animated: true, completion: nil)
        
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        func transitionToApp() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        }
        
        // TODO: Validate Text Fields
        // Create cleaned versions of the text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else {
                transitionToApp()}
//            } else if { This would be where the user's doc is read for their withdrawal status. If withdrawn, then can't sign in.
//                func logUserOut() {
//
//
//                    // MARK: 1.4.1 - Signing out the User
//                    let firebaseAuth = Auth.auth()
//                    do {
//                        try firebaseAuth.signOut()
//
//                    } catch let signOutError as NSError {
//                        print("Error signing out: %@", signOutError)
//                    }
//                }
//
//                logUserOut() // without, user still is able to log in due to authentication code above
//                // MARK: 1.4.3 - Create the alert (Separate into it's own method later)
//                let alert = UIAlertController(title: "Warning: Withdrawal Notice", message: "You have selected to withdraw from the research study which will require you to _. By selecting 'I Understand' you are confirming that you understand proceeding will cancel your participation within the study and will thus require you to promptly return any research related devices.", preferredStyle: .alert)
//
//                alert.addAction(UIAlertAction(title: "Email Us", style: UIAlertAction.Style.default, handler: {
//
//                    // 1.4.3.1 - Define the action of presenting the withdrawal survey to user
//                    action in
//                    self.showMailComposer()
//
//                }))
//
//                // 1.4.3.2 - Define the action of dismissing alert view controller
//                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel, handler: {
//                    action in alert.dismiss(animated: true, completion: nil)
//                }))
//
//                // 1.4.4 - Show the alert
//                self.present(alert, animated: true, completion: nil)
//            }
//
            
        }
    }
    
}



extension LoginViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if let _ = error {
            controller.dismiss(animated: true)
            return
        }
        
        switch result {
        case .cancelled:
            print("Cancelled")
        case .failed:
            print("failed")
        case .saved:
            print("Saved")
        case .sent:
            print("email sent")
        @unknown default:
            print("fatal error")
        }
        
        controller.dismiss(animated: true)
    }
}
