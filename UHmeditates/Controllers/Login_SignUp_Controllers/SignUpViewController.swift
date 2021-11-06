//
//  SignUpViewController.swift
//  UHmeditates
//
//  Created by Chase Philip on 1/25/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseCore

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var FirstNameTextField: UITextField!
    
    @IBOutlet weak var LastNameTextField: UITextField!
    
    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    public var currentUser = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        
    }
    
    func setUpElements() {
        
        // Hide error label
        errorLabel.alpha = 0
    }

    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if FirstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            LastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            EmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            PasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        // Check if the password is secure
        let cleanedPassword = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if SignUpViewController.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        let error = validateFields()
        
        if error != nil {
            
            // There's something wrong with the fields, show error message
            showError(error!)
        }
        else {
            
            // Create cleaned versions of the data
            let firstName = FirstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = LastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                // Check for errors
                if err != nil {
                    
                    // There was an error creating the user
                    self.showError("Error creating user")
                }
                else {
                    
                    // User was created successfully, now store the first name and last name
                    self.currentUser = "\(email)"
                    
                    let db = Firestore.firestore()
                    
                    // Within the users collection, create a firebase doc titled after the new users uniqueID
                    db.collection("users").document("\(result!.user.uid)").setData([
                                                                            "firstname":firstName,
                                                                            "lastname":lastName,
                                                                            "uid": result!.user.uid ])
                    { (error) in
                        if error != nil {
                            // Show error message
                            self.showError("Error saving user data")
                            // old code for generating a firebase document with randomized ID
                            //                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid ]) { (error) in
                            //                        if error != nil {
                            //                            // Show error message
                            //                            self.showError("Error saving user data")
                        }
                    }
                    
                    // Transition to the home screen
                    self.transitionToJoinStudyPage()
                }
            }
        }
    }
    
    func transitionToJoinStudyPage() {
        
        let homeViewController = storyboard?.instantiateViewController(identifier: "joinStudyVC") as? DemographicSignupViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
}


