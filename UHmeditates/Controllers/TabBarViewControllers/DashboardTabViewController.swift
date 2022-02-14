//
//  DashboardTabViewController.swift
//  UHmeditates
//
//  Created by Tyler Boston on 8/9/21.
//

import UIKit
import ResearchKit
import os.log

// MARK: New Code

///


class DashboardTabViewController: UIViewController {

    @IBOutlet weak var labelOne: UILabel!
    
    func openingWebsite() {
        
        if let url = URL(string: "https://www.mindfuluh.org") {
            UIApplication.shared.open(url)
        }
    }
    func openPodcastOnSpotify () {
        
        let spotifyApplication = UIApplication.shared
        let spotifyAppPath = "spotify://"
        let spotifyAppUrl = URL(string: spotifyAppPath)! // error w/ prop initializer
        let spotifyWebUrl = URL(string: "https://open.spotify.com/show/1D3E4BigFQZ5h4qNAY4IX3?si=dd516e1007d644b5")!

        if spotifyApplication.canOpenURL(spotifyAppUrl) {

            spotifyApplication.open(spotifyAppUrl, options: [:], completionHandler: nil)
        } else {
            spotifyApplication.open(spotifyWebUrl)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelOne.layer.borderWidth = 0
        labelOne.layer.cornerRadius = 10
        
       
    }
    
    @IBAction func websiteButton(_ sender: UIButton) {
        openingWebsite()
    }
    
    @IBAction func spotifyButton(_ sender: UIButton) {
        
        openPodcastOnSpotify()
    }
    
    // Code for linking spotify
    

}
