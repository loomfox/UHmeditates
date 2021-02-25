//
//  HomeViewController.swift
//  UHmeditates
//
//  Created by Chase Philip on 1/25/21.
//

import UIKit

class HomeViewController: UIViewController {
    

    //@IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var scrollView:UIScrollView!
    
    lazy var week1Button: UILabel = {
        let week1Button = UILabel()
        week1Button.text = "Week 1"
        week1Button.textColor = .black
        week1Button.font = .systemFont(ofSize: 30.0)
        week1Button.frame = CGRect(x:8, y: 271, width:140, height: 66)
        return week1Button
    }()
    
    @objc func med1Action(button: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "Week1Med1")
        
    }
    
    lazy var week1Med1: UIButton = {
        let week1Med1 = UIButton()
        week1Med1.setImage(UIImage(named: "W1Med1"), for: .normal)
        week1Med1.frame = CGRect(x:20, y: 326, width:120, height: 107)
        week1Med1.addTarget(self, action: #selector(med1Action), for: .touchUpInside)
        return week1Med1
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+100)
        scrollView.addSubview(week1Button)
        scrollView.addSubview(week1Med1)
            
            //CGSizeMake(self.view.frame.width, self.view.frame.height+100)
    }
    // small change here
    
    
    
    
    
    
    /*
    // MARK: - Navigation

     }
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}
