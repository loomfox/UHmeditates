//
//  LoginViewController.swift
//  UHmeditates
//
//  Created by Chase Philip on 1/25/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
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
    
    func verifyEnrollment () -> String {
        
        
        return "hi"
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
                if self.verifyEnrollment() == "Enrolled" {
                    transitionToApp()
                } else {
                    // MARK: 1.4.3 - Create the alert (Separate into it's own method later)
                    let alert = UIAlertController(title: "Warning: Withdrawal Notice", message: "You have selected to withdraw from the research study which will require you to _. By selecting 'I Understand' you are confirming that you understand proceeding will cancel your participation within the study and will thus require you to promptly return any research related devices.", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Email Us", style: UIAlertAction.Style.default, handler: {
                        
                        // 1.4.3.1 - Define the action of presenting the withdrawal survey to user
                        action in
                        CommunicationsTabViewController().showMailComposer()
                        
                    }))
                    
                        // 1.4.3.2 - Define the action of dismissing alert view controller
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel, handler: {
                        action in alert.dismiss(animated: true, completion: nil)
                    }))
                    
                    // 1.4.4 - Show the alert
                    self.present(alert, animated: true, completion: nil)
                }
                
                
            }
        }
        
    }
    
}
