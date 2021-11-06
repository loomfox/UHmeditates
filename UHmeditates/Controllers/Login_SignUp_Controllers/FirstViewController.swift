//
//  ViewController.swift
//  UHmeditates
//
//  Created by Chase Philip on 1/25/21.
//
import Firebase
import UIKit

class FirstViewController: UIViewController {

    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func transitionToApp() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                   let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                   (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        }
        
        if Auth.auth().currentUser != nil {
            // User is signed in.
            // . . .
            
            transitionToApp()
            
        } else {
            //No user is signed in.
            //...
            
            print("No one is signed in.")
        }
        
        // Do any additional setup after loading the view.
    }


}

