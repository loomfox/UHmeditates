//
//  HomeViewController.swift
//  UHmeditates
//
//  Created by Chase Philip on 1/25/21.
//

//MARK: Review Video from Piya
    /// Questions:
        // Is it necessary to create another VC for each button or can we use a function that switches out that information and then can store the information that's dependent on the Unique Identifier which could be the string for each buttons name?
        // Can this be done using a struct that will replace the information dependent on a switch case statement?
        // If it can, create a separate file to house the quiz structure + elements w/ the functions. The physical elements that belong to the UIKit will be programmed in to the ViewController housing the items.
        //


import UIKit

class HomeViewController: UIViewController {
    

    //@IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var scrollView:UIScrollView!
    
    // For week 1 label
    lazy var week1Label: UILabel = {
        let week1Button = UILabel()
        week1Button.text = "Week 1"
        week1Button.textColor = .black
        week1Button.font = .systemFont(ofSize: 30.0)
        week1Button.frame = CGRect(x:8, y: 271, width:140, height: 66)
        return week1Button
    }()
    
    // For week 1 meditation 1 action
    @objc func week1med1Action(button: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "Week1Med1") as! Week1Med1Controller
        present(vc, animated: true)
    }
    
    // For week 1 meditation 1 button to initiate the action
    lazy var week1Med1: UIButton = {
        let week1Med1 = UIButton()
        week1Med1.setImage(UIImage(named: "W1Med1"), for: .normal)
        week1Med1.frame = CGRect(x:20, y: 326, width:120, height: 107)
        week1Med1.addTarget(self, action: #selector(week1med1Action), for: .touchUpInside)
        return week1Med1
    }()
    
    
    @objc func week1med2Action(button: UIButton){
        _ = storyboard?.instantiateViewController(withIdentifier: "Week1Med2")
        //present(vc, animated: true)
    }
    
    lazy var week1Med2: UIButton = {
        let week1Med1 = UIButton()
        week1Med1.setImage(UIImage(named: "W1Med1"), for: .normal)
        week1Med1.frame = CGRect(x:150, y: 326, width:120, height: 107)
        //week1Med1.addTarget(self, action: #selector(week1med2Action), for: .touchUpInside)
        return week1Med1
    }()
    
    @objc func week1med3Action(button: UIButton){
        _ = storyboard?.instantiateViewController(withIdentifier: "Week1Med3")
        //present(vc, animated: true)
    }
    
    lazy var week1Med3: UIButton = {
        let week1Med1 = UIButton()
        week1Med1.setImage(UIImage(named: "W1Med1"), for: .normal)
        week1Med1.frame = CGRect(x:280, y: 326, width:120, height: 107)
        //week1Med1.addTarget(self, action: #selector(week1med2Action), for: .touchUpInside)
        return week1Med1
    }()
    
    
    
    
    
    //week2
    
    
    lazy var week2Label: UILabel = {
        let week1Button = UILabel()
        week1Button.text = "Week 2"
        week1Button.textColor = .black
        week1Button.font = .systemFont(ofSize: 30.0)
        week1Button.frame = CGRect(x:8, y: 476, width:140, height: 66)
        return week1Button
    }()
    
    @objc func week2med1Action(button: UIButton){
        _ = storyboard?.instantiateViewController(withIdentifier: "Week2Med1")
        //present(vc, animated: true)
    }
    
    lazy var week2Med1: UIButton = {
        let week1Med1 = UIButton()
        week1Med1.setImage(UIImage(named: "W1Med1"), for: .normal)
        week1Med1.frame = CGRect(x:20, y: 531, width:120, height: 107)
        //week1Med1.addTarget(self, action: #selector(week1med2Action), for: .touchUpInside)
        return week1Med1
    }()
    
    @objc func week2med2Action(button: UIButton){
        _ = storyboard?.instantiateViewController(withIdentifier: "Week2Med2")
        //present(vc, animated: true)
    }
    
    lazy var week2Med2: UIButton = {
        let week1Med1 = UIButton()
        week1Med1.setImage(UIImage(named: "W1Med1"), for: .normal)
        week1Med1.frame = CGRect(x:150, y: 531, width:120, height: 107)
        //week1Med1.addTarget(self, action: #selector(week1med2Action), for: .touchUpInside)
        return week1Med1
    }()
    
    @objc func week2med3Action(button: UIButton){
        _ = storyboard?.instantiateViewController(withIdentifier: "Week2Med3")
        //present(vc, animated: true)
    }
    
    lazy var week2Med3: UIButton = {
        let week1Med1 = UIButton()
        week1Med1.setImage(UIImage(named: "W1Med1"), for: .normal)
        week1Med1.frame = CGRect(x:280, y: 531, width:120, height: 107)
        //week1Med1.addTarget(self, action: #selector(week1med2Action), for: .touchUpInside)
        return week1Med1
    }()
    
    
    
    
    
    
    //week3
    
    
    lazy var week3Label: UILabel = {
        let week1Button = UILabel()
        week1Button.text = "Week 3"
        week1Button.textColor = .black
        week1Button.font = .systemFont(ofSize: 30.0)
        week1Button.frame = CGRect(x:8, y: 681, width:140, height: 66)
        return week1Button
    }()
    
    @objc func week3med1Action(button: UIButton){
        _ = storyboard?.instantiateViewController(withIdentifier: "Week2Med1")
        //present(vc, animated: true)
    }
    
    lazy var week3Med1: UIButton = {
        let week1Med1 = UIButton()
        week1Med1.setImage(UIImage(named: "W1Med1"), for: .normal)
        week1Med1.frame = CGRect(x:20, y: 736, width:120, height: 107)
        //week1Med1.addTarget(self, action: #selector(week1med2Action), for: .touchUpInside)
        return week1Med1
    }()
    
    @objc func week3med2Action(button: UIButton){
        _ = storyboard?.instantiateViewController(withIdentifier: "Week2Med2")
        //present(vc, animated: true)
    }
    
    lazy var week3Med2: UIButton = {
        let week1Med1 = UIButton()
        week1Med1.setImage(UIImage(named: "W1Med1"), for: .normal)
        week1Med1.frame = CGRect(x:150, y: 736, width:120, height: 107)
        //week1Med1.addTarget(self, action: #selector(week1med2Action), for: .touchUpInside)
        return week1Med1
    }()
    
    @objc func week3med3Action(button: UIButton){
        _ = storyboard?.instantiateViewController(withIdentifier: "Week2Med3")
        //present(vc, animated: true)
    }
    
    lazy var week3Med3: UIButton = {
        let week1Med1 = UIButton()
        week1Med1.setImage(UIImage(named: "W1Med1"), for: .normal)
        week1Med1.frame = CGRect(x:280, y: 736, width:120, height: 107)
        //week1Med1.addTarget(self, action: #selector(week1med2Action), for: .touchUpInside)
        return week1Med1
    }()
    
    
    
    
    
    
    
    //week4
    
    
    lazy var week4Label: UILabel = {
        let week1Button = UILabel()
        week1Button.text = "Week 4"
        week1Button.textColor = .black
        week1Button.font = .systemFont(ofSize: 30.0)
        week1Button.frame = CGRect(x:8, y: 886, width:140, height: 66)
        return week1Button
    }()
    
    @objc func week4med1Action(button: UIButton){
        _ = storyboard?.instantiateViewController(withIdentifier: "Week2Med1")
        //present(vc, animated: true)
    }
    
    lazy var week4Med1: UIButton = {
        let week1Med1 = UIButton()
        week1Med1.setImage(UIImage(named: "W1Med1"), for: .normal)
        week1Med1.frame = CGRect(x:20, y: 941, width:120, height: 107)
        //week1Med1.addTarget(self, action: #selector(week1med2Action), for: .touchUpInside)
        return week1Med1
    }()
    
    @objc func week4med2Action(button: UIButton){
        _ = storyboard?.instantiateViewController(withIdentifier: "Week2Med2")
        //present(vc, animated: true)
    }
    
    lazy var week4Med2: UIButton = {
        let week1Med1 = UIButton()
        week1Med1.setImage(UIImage(named: "W1Med1"), for: .normal)
        week1Med1.frame = CGRect(x:150, y: 941, width:120, height: 107)
        //week1Med1.addTarget(self, action: #selector(week1med2Action), for: .touchUpInside)
        return week1Med1
    }()
    
    @objc func week4med3Action(button: UIButton){
        _ = storyboard?.instantiateViewController(withIdentifier: "Week2Med3")
        //present(vc, animated: true)
    }
    
    lazy var week4Med3: UIButton = {
        let week1Med1 = UIButton()
        week1Med1.setImage(UIImage(named: "W1Med1"), for: .normal)
        week1Med1.frame = CGRect(x:280, y: 941, width:120, height: 107)
        //week1Med1.addTarget(self, action: #selector(week1med2Action), for: .touchUpInside)
        return week1Med1
    }()
    
    
    
    
    
    
    
    
    //week5
    
    
    lazy var week5Label: UILabel = {
        let week1Button = UILabel()
        week1Button.text = "Week 5"
        week1Button.textColor = .black
        week1Button.font = .systemFont(ofSize: 30.0)
        week1Button.frame = CGRect(x:8, y: 1091, width:140, height: 66)
        return week1Button
    }()
    
    @objc func week5med1Action(button: UIButton){
        _ = storyboard?.instantiateViewController(withIdentifier: "Week2Med1")
        //present(vc, animated: true)
    }
    
    lazy var week5Med1: UIButton = {
        let week1Med1 = UIButton()
        week1Med1.setImage(UIImage(named: "W1Med1"), for: .normal)
        week1Med1.frame = CGRect(x:20, y: 1146, width:120, height: 107)
        //week1Med1.addTarget(self, action: #selector(week1med2Action), for: .touchUpInside)
        return week1Med1
    }()
    
    @objc func week5med2Action(button: UIButton){
        _ = storyboard?.instantiateViewController(withIdentifier: "Week2Med2")
        //present(vc, animated: true)
    }
    
    lazy var week5Med2: UIButton = {
        let week1Med1 = UIButton()
        week1Med1.setImage(UIImage(named: "W1Med1"), for: .normal)
        week1Med1.frame = CGRect(x:150, y: 1146, width:120, height: 107)
        //week1Med1.addTarget(self, action: #selector(week1med2Action), for: .touchUpInside)
        return week1Med1
    }()
    
    @objc func week5med3Action(button: UIButton){
        _ = storyboard?.instantiateViewController(withIdentifier: "Week2Med3")
        //present(vc, animated: true)
    }
    
    lazy var week5Med3: UIButton = {
        let week1Med1 = UIButton()
        week1Med1.setImage(UIImage(named: "W1Med1"), for: .normal)
        week1Med1.frame = CGRect(x:280, y: 1146, width:120, height: 107)
        //week1Med1.addTarget(self, action: #selector(week1med2Action), for: .touchUpInside)
        return week1Med1
    }()
    
    
    
    
    
    
    
    
    //week6
    
    
    lazy var week6Label: UILabel = {
        let week1Button = UILabel()
        week1Button.text = "Week 6"
        week1Button.textColor = .black
        week1Button.font = .systemFont(ofSize: 30.0)
        week1Button.frame = CGRect(x:8, y: 1296, width:140, height: 66)
        return week1Button
    }()
    
    @objc func week6med1Action(button: UIButton){
        _ = storyboard?.instantiateViewController(withIdentifier: "Week2Med1")
        //present(vc, animated: true)
    }
    
    lazy var week6Med1: UIButton = {
        let week1Med1 = UIButton()
        week1Med1.setImage(UIImage(named: "W1Med1"), for: .normal)
        week1Med1.frame = CGRect(x:20, y: 1351, width:120, height: 107)
        //week1Med1.addTarget(self, action: #selector(week1med2Action), for: .touchUpInside)
        return week1Med1
    }()
    
    @objc func week6med2Action(button: UIButton){
        _ = storyboard?.instantiateViewController(withIdentifier: "Week2Med2")
        //present(vc, animated: true)
    }
    
    lazy var week6Med2: UIButton = {
        let week1Med1 = UIButton()
        week1Med1.setImage(UIImage(named: "W1Med1"), for: .normal)
        week1Med1.frame = CGRect(x:150, y: 1351, width:120, height: 107)
        //week1Med1.addTarget(self, action: #selector(week1med2Action), for: .touchUpInside)
        return week1Med1
    }()
    
    @objc func week6med3Action(button: UIButton){
        _ = storyboard?.instantiateViewController(withIdentifier: "Week2Med3")
        //present(vc, animated: true)
    }
    
    lazy var week6Med3: UIButton = {
        let week1Med1 = UIButton()
        week1Med1.setImage(UIImage(named: "W1Med1"), for: .normal)
        week1Med1.frame = CGRect(x:280, y: 1351, width:120, height: 107)
        //week1Med1.addTarget(self, action: #selector(week1med2Action), for: .touchUpInside)
        return week1Med1
    }()
    
    
    
    
    
    
    //week7
    
    
    lazy var week7Label: UILabel = {
        let week1Button = UILabel()
        week1Button.text = "Week 7"
        week1Button.textColor = .black
        week1Button.font = .systemFont(ofSize: 30.0)
        week1Button.frame = CGRect(x:8, y: 1501, width:140, height: 66)
        return week1Button
    }()
    
    @objc func week7med1Action(button: UIButton){
        _ = storyboard?.instantiateViewController(withIdentifier: "Week2Med1")
        //present(vc, animated: true)
    }
    
    lazy var week7Med1: UIButton = {
        let week1Med1 = UIButton()
        week1Med1.setImage(UIImage(named: "W1Med1"), for: .normal)
        week1Med1.frame = CGRect(x:20, y: 1556, width:120, height: 107)
        //week1Med1.addTarget(self, action: #selector(week1med2Action), for: .touchUpInside)
        return week1Med1
    }()
    
    @objc func week7med2Action(button: UIButton){
        _ = storyboard?.instantiateViewController(withIdentifier: "Week2Med2")
        //present(vc, animated: true)
    }
    
    lazy var week7Med2: UIButton = {
        let week1Med1 = UIButton()
        week1Med1.setImage(UIImage(named: "W1Med1"), for: .normal)
        week1Med1.frame = CGRect(x:150, y: 1556, width:120, height: 107)
        //week1Med1.addTarget(self, action: #selector(week1med2Action), for: .touchUpInside)
        return week1Med1
    }()
    
    @objc func week7med3Action(button: UIButton){
        _ = storyboard?.instantiateViewController(withIdentifier: "Week2Med3")
        //present(vc, animated: true)
    }
    
    lazy var week7Med3: UIButton = {
        let week1Med1 = UIButton()
        week1Med1.setImage(UIImage(named: "W1Med1"), for: .normal)
        week1Med1.frame = CGRect(x:280, y: 1556, width:120, height: 107)
        //week1Med1.addTarget(self, action: #selector(week1med2Action), for: .touchUpInside)
        return week1Med1
    }()

    
    
    //week8
    
    
    lazy var week8Label: UILabel = {
        let week1Button = UILabel()
        week1Button.text = "Week 8"
        week1Button.textColor = .black
        week1Button.font = .systemFont(ofSize: 30.0)
        week1Button.frame = CGRect(x:8, y: 1706, width:140, height: 66)
        return week1Button
    }()
    
    @objc func week8med1Action(button: UIButton){
        _ = storyboard?.instantiateViewController(withIdentifier: "Week2Med1")
        //present(vc, animated: true)
    }
    
    lazy var week8Med1: UIButton = {
        let week1Med1 = UIButton()
        week1Med1.setImage(UIImage(named: "W1Med1"), for: .normal)
        week1Med1.frame = CGRect(x:20, y: 1761, width:120, height: 107)
        //week1Med1.addTarget(self, action: #selector(week1med2Action), for: .touchUpInside)
        return week1Med1
    }()
    
    @objc func week8med2Action(button: UIButton){
        _ = storyboard?.instantiateViewController(withIdentifier: "Week2Med2")
        //present(vc, animated: true)
    }
    
    lazy var week8Med2: UIButton = {
        let week1Med1 = UIButton()
        week1Med1.setImage(UIImage(named: "W1Med1"), for: .normal)
        week1Med1.frame = CGRect(x:150, y: 1761, width:120, height: 107)
        //week1Med1.addTarget(self, action: #selector(week1med2Action), for: .touchUpInside)
        return week1Med1
    }()
    
    @objc func week8med3Action(button: UIButton){
        _ = storyboard?.instantiateViewController(withIdentifier: "Week2Med3")
        //present(vc, animated: true)
    }
    
    lazy var week8Med3: UIButton = {
        let week1Med1 = UIButton()
        week1Med1.setImage(UIImage(named: "W1Med1"), for: .normal)
        week1Med1.frame = CGRect(x:280, y: 1761, width:120, height: 107)
        //week1Med1.addTarget(self, action: #selector(week1med2Action), for: .touchUpInside)
        return week1Med1
    }()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+1200)
        scrollView.addSubview(week1Label)
        scrollView.addSubview(week1Med1)
        scrollView.addSubview(week1Med2)
        scrollView.addSubview(week1Med3)
        
        scrollView.addSubview(week2Label)
        scrollView.addSubview(week2Med1)
        scrollView.addSubview(week2Med2)
        scrollView.addSubview(week2Med3)
        
        scrollView.addSubview(week3Label)
        scrollView.addSubview(week3Med1)
        scrollView.addSubview(week3Med2)
        scrollView.addSubview(week3Med3)
        
        scrollView.addSubview(week4Label)
        scrollView.addSubview(week4Med1)
        scrollView.addSubview(week4Med2)
        scrollView.addSubview(week4Med3)
        
        scrollView.addSubview(week5Label)
        scrollView.addSubview(week5Med1)
        scrollView.addSubview(week5Med2)
        scrollView.addSubview(week5Med3)
        
        scrollView.addSubview(week6Label)
        scrollView.addSubview(week6Med1)
        scrollView.addSubview(week6Med2)
        scrollView.addSubview(week6Med3)
        
        scrollView.addSubview(week7Label)
        scrollView.addSubview(week7Med1)
        scrollView.addSubview(week7Med2)
        scrollView.addSubview(week7Med3)
        
        scrollView.addSubview(week8Label)
        scrollView.addSubview(week8Med1)
        scrollView.addSubview(week8Med2)
        scrollView.addSubview(week8Med3)
        
            
    }
    
    
    
    
    let dog = "Bark"
    
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
