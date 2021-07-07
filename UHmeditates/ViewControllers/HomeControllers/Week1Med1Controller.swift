//
//  Week1Med1Controller.swift
//  UHmeditates
//
//  Created by Piya Malhan on 2/23/21.
//

import UIKit
import Firebase



class Week1Med1Controller:  UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonFour: UIButton!
    @IBOutlet weak var buttonFive: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    private let db = Firestore.firestore()
    private var quizDoc = db.collection("ButtonNamedCollectionHere").document("MeditationButton")
    
    var relevantVC = HomeViewController()
    var quizBrain = MeditationQuiz()
    var userAnswer: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let
        
        
        // MARK: TASK - setup an if statement for if the db collection with "name" is not present in firebase, then create one w/ name. Else, print("Database is present")
        
        
        
    
        
//db.collection("ButtonNamedCollectionHere").addDocument(data: [String(format: "Test", quizBrain.questionNumber) : userAnswer])
      
//        print("\(relevantVC.buttonName)")
    
// MARK: Code that only needs to be ran once here
            updateUI()
        
    }
    
    
    
    setData(["\(quizBrain.getQuestionText())":"\(userAnswer ?? "no answer")"])
// MARK: IBActions Go Here

    @IBAction func answerPressed(_ sender: UIButton) {
        userAnswer = sender.currentTitle!
            if userAnswer != nil {
                sender.backgroundColor = UIColor.cyan
            }
    }
    
    @IBAction func nextQuestion(_ sender: UIButton) {
        
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        print(userAnswer ?? "nil")
        quizBrain.nextQuestion()
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
        
    }
    

}
