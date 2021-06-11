//
//  Week1Med1Controller.swift
//  UHmeditates
//
//  Created by Piya Malhan on 2/23/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseCore


class Week1Med1Controller: UIViewController {
    
    
    @IBOutlet weak var EmailTextField: UITextField!
    //let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func surveyButtonTapped(_ sender: Any){
        let db = Firestore.firestore()
        let email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        db.collection("week1").addDocument(data: ["email": email])
    }

}
