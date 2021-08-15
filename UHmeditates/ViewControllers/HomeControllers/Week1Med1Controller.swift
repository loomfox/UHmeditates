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

import AVKit

class Week1Med1Controller: UIViewController {
  
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()
    
    
    @IBOutlet weak var EmailTextField: UITextField!
    //let db = Firestore.firestore()

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonFour: UIButton!
    @IBOutlet weak var buttonFive: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    var quizBrain = MeditationQuiz()
    var userAnswer = "String"
    
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
        
        db.collection("ButtonNamedCollectionHere").addDocument(data: [String(format: "Test", quizBrain.questionNumber) : userAnswer])
    
// MARK: Code that only needs to be ran once here
            updateUI()
        
    }


// MARK: IBActions Go Here

    @IBAction func answerPressed(_ sender: UIButton) {
        userAnswer = sender.currentTitle!
            if userAnswer != nil {
                sender.backgroundColor = UIColor.cyan
            }
    }
    
    @IBAction func nextQuestion(_ sender: UIButton) {
        
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        print(userAnswer)
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
    

  
    @IBAction func abutton(_ sender: UIButton) { audioPlayer.play()
        
        func preparePlayer() {
        guard let url = URL(string: "gs://uhmed-318b3.appspot.com/Meliza_one minute centering meditation.m4a") else {
            print("Invalid URL")
            return
        }
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSession.Category.playback)
            let soundData = try Data(contentsOf: url)
            audioPlayer = try AVAudioPlayer(data: soundData)
            audioPlayer.volume = 1
            let minuteString = String(format: "%02d", (Int(audioPlayer.duration) / 60))
            let secondString = String(format: "%02d", (Int(audioPlayer.duration) % 60))
            print("TOTAL TIMER: \(minuteString):\(secondString)")
        } catch {
            print(error)
        }
    }
    }
}
    

