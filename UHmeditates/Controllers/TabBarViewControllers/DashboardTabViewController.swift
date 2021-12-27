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

    func openingWebsite() {
        
        if let url = URL(string: "https://www.mindfuluh.org") {
            UIApplication.shared.open(url)
        }
    }
    func openPodcastOnSpotify () {
        
        let spotifyApplication = UIApplication.shared
        let spotifyAppPath = "spotify://"
        let spotifyAppUrl = URL(string: spotifyAppPath)! // error w/ prop initializer
        let spotifyWebUrl = URL(string: "https://play.spotify.com")!

        if spotifyApplication.canOpenURL(spotifyAppUrl) {

            spotifyApplication.open(spotifyAppUrl, options: [:], completionHandler: nil)
        } else {
            spotifyApplication.open(spotifyWebUrl)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
    }
    
    @IBAction func websiteButton(_ sender: UIButton) {
        openingWebsite()
    }
    
    @IBAction func spotifyButton(_ sender: UIButton) {
        
        openPodcastOnSpotify()
    }
    
    // Code for linking spotify
    

}
