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


