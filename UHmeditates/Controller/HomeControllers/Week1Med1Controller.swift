//
//  Week1Med1Controller.swift
//  UHmeditates
//
//  Created by Piya Malhan on 2/23/21.
//

import UIKit
import Firebase
import ResearchKit



class Week1Med1Controller: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonFour: UIButton!
    @IBOutlet weak var buttonFive: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var submitButton: UIButton!
    
    var quizSubmission: [String : Any] = [:]
    var relevantVC = HomeViewController()
    var quizBrain = MeditationQuiz()
    var userAnswer: String?
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.title = MeditationQuiz.weekTitle
        
        submitButton.isHidden = true
        
        buttonOne.layer.borderWidth = 1 / 2
        buttonOne.layer.cornerRadius = 15
        buttonOne.layer.borderColor = UIColor.gray.cgColor
        
        buttonTwo.layer.borderWidth = 1 / 2
        buttonTwo.layer.cornerRadius = 15
        buttonTwo.layer.borderColor = UIColor.gray.cgColor
        
        buttonThree.layer.borderWidth = 1 / 2
        buttonThree.layer.cornerRadius = 15
        buttonThree.layer.borderColor = UIColor.gray.cgColor
        
        buttonFour.layer.borderWidth = 1 / 2
        buttonFour.layer.cornerRadius = 15
        buttonFour.layer.borderColor = UIColor.gray.cgColor
        
        buttonFive.layer.borderWidth = 1 / 2
        buttonFive.layer.cornerRadius = 15
        buttonFive.layer.borderColor = UIColor.gray.cgColor
        
        // MARK: Code that only needs to be ran once here
        updateUI()
        
    }
    //MARK: IBActions Go Here
    
    @IBAction func answerPressed(_ sender: UIButton) {
        
        if let userAnswer = sender.currentTitle,
           let questionNumber = questionLabel.text {
            sender.backgroundColor = UIColor.cyan
            quizSubmission[questionNumber] = userAnswer
        }
    }
    
    @IBAction func nextQuestion(_ sender: UIButton) {
        
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        print(userAnswer ?? "nil")
        quizBrain.nextQuestion()
    }
    
    @IBAction func submitAction(_ sender: Any) {
        print(quizSubmission)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
        
        db.collection("ExampleUser").document(MeditationQuiz.weekTitle).setData( quizSubmission) { (error) in
            if let e = error{
                print("There was an issue saving data to firestore, \(e)")
            } else {
                print("Successfully saved data.")
            }
            
        }
        resetQuizArray()
        performSegue(withIdentifier: "QuizToHome", sender: self)
    }
    
    func resetQuizArray () {
        quizSubmission.removeAll(keepingCapacity: false)
    }
    
    // MARK: Refreshes UI
    @objc func updateUI(){
        
        questionLabel.text = "\(quizBrain.questionNumber + 1). " + quizBrain.getQuestionText()
        buttonOne.setTitle("\(quizBrain.getAnswerText()[0])", for: .normal)
        buttonTwo.setTitle("\(quizBrain.getAnswerText()[1])", for: .normal)
        buttonThree.setTitle("\(quizBrain.getAnswerText()[2])", for: .normal)
        buttonFour.setTitle("\(quizBrain.getAnswerText()[3])", for: .normal)
        buttonFive.setTitle("\(quizBrain.getAnswerText()[4])", for: .normal)
        progressBar.progress = quizBrain.getProgress()
        buttonOne.backgroundColor = UIColor.clear
        buttonTwo.backgroundColor = UIColor.clear
        buttonThree.backgroundColor = UIColor.clear
        
        if quizBrain.questionNumber == 2 {
            nextButton.isHidden = true
            submitButton.isHidden = false
        }
    }
}
