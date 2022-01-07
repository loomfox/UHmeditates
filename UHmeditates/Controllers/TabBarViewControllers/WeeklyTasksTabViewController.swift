//
//  WeeklyTasksTabViewController.swift
//  UHmeditates
//
//  Created by Chase Philip on 1/25/21.
//STATUS: 🟢 == Fully Functioning, 🟡 == Useable State but not complete, 🔴 == Not functioning
/// ⚠️ == Missing Component
/// 🔶 == Question
/// ✅ == Part Completed
/// ❌ == Part Incomplete

// Can't figure out why i can't add them as reference outlets to modify their properties 

import UIKit
import Firebase
import FirebaseAuth
import ResearchKit
import FirebaseFirestore

class WeeklyTasksTabViewController: UIViewController, UITableViewDataSource, ORKTaskViewControllerDelegate {
    
    // MARK: Button outlets
    @IBOutlet weak var buttonOneO: UIButton!
    @IBOutlet var progressBarOutlet: UIView!
    
    @IBOutlet weak var progresBarHeader: UILabel!
    @IBOutlet weak var theTableView: UITableView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var testSurveys = [CompletedSurveyItem]()
    let dfParser: DateFormatter = {
        //let s = "2021-12-18 15:30:57 +0000"
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
//        df.date(from: s)
        return df
    }()
    
    let dfOutputter: DateFormatter = {
        //let s = "2021-12-18 15:30:57 +0000"
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .short
//        df.date(from: s)
        return df
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
//        return surveysCompleteToDate
        return self.testSurveys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "ReusableCellId"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) else {
            return UITableViewCell()
        }

        let survey = self.testSurveys[indexPath.row]
        cell.textLabel?.text = survey.surveyName

        var date = survey.endDate
        if let parsed = dfParser.date(from:survey.endDate) {
            date = dfOutputter.string(from:parsed)
        }
        cell.detailTextLabel?.text = date
        return cell
    }
    
    
    // MARK: Variables that'll potentially be stored as UserDefaults
    var isOnboardingComplete = false
    var surveysCompleteToDate = 2 // MARK: Implement listener from firebase here, & have this variable created at signup
    var surveysCompleteThisWeek = 0
    let totalStudySurveys = 24

  var surveys = [
          //  CompletedSurveyItem
        ["title": "1", "date": "12/15"],
        ["title": "2", "date": "12/16"]
    ] // Here I need to place the new objects from the listener
    
    
    // MARK: Testing getData func

//    var testSurveys = [CompletedSurveyItem]()
    
    func getData() {
        
        // reference to database
        let db = Firestore.firestore()
        
        // read doc at specific path
        db.collection("users").getDocuments { snapshot, error in //documents will be stored in the snapshot parameter in object called document or "d"
            if error == nil {
                
                //no errors
                if let snapshot = snapshot {
                    
                    // get all the documents and create an instance of the completedsurveyitem struct
                    DispatchQueue.main.async {
                        
                        self.testSurveys = snapshot.documents.map { d in // map function iterates through array and performs code on each item and returns a collection
                            
                            // return a completedsurveyitem since that's the type of object we want to create
                            print("ID: \(d.documentID)")
                            return CompletedSurveyItem(id: d.documentID,
                                                       endDate: d["Task End:"] as? String ?? "",
                                                       surveyName: d["survey"] as? String ?? "")
                            // 🔴 Problem: Can't figure out how to get the information from the CompletedSurveyItem to be printed into a table, or as a simple string into a label.
                            
                        }
                        print("Num testSurveys: \(self.testSurveys.count)")
                        self.tableView.reloadData()
                    }
                    
                    
                    
                } else{
                    //handle the error
                    print("Error Message: \(error)")
                }
            }
        }
        
    }
    

    
    
    // MARK: ORKTaskVC Dismiss
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        
        let userID = Auth.auth().currentUser?.uid
        let docTitle = "SurveyNum" + "\(surveysCompleteToDate)"
        
        TaskComponents.verifyDocExist(docTitle: docTitle) { doesExist in
            if doesExist == false {
                print(docTitle)
                
                TaskComponents.createDoc(docTitle: docTitle)
                
                let preResults: [ORKChoiceQuestionResult] = (taskViewController.result.results![1] as! ORKStepResult).results as! [ORKChoiceQuestionResult]
                
                // Loop of assigning pre results ID and answer values
                for result in preResults {
                    let resultIdentifier = "\(result.identifier)"
                    let resultValue = "\(result.answer ?? "null")"
                    
                    // Storing the answers in a looped process
                    TaskComponents.storeCheckInPreSurveyResults(docTitle: docTitle, resultID: resultIdentifier, resultValue: resultValue)
                }
                
                let postResults: [ORKChoiceQuestionResult] = (taskViewController.result.results![3] as! ORKStepResult).results as! [ORKChoiceQuestionResult]
                for result in postResults {
                    
                    let resultIdentifier = "\(result.identifier)"
                    let resultValue = "\(result.answer ?? "null")"
                    
                    TaskComponents.storeCheckInPostSurveyResults(docTitle: docTitle, resultID: resultIdentifier, resultValue: resultValue, user: userID!, start: "\(taskViewController.result.startDate)", end: "\(taskViewController.result.endDate)")
                }
            } else {
                print("Does exist, no write made to db")
            }
        }
        
        
        if taskViewController.result.results != nil {
            //surveysCompleteToDate += 1
            print("Not Nil, meaning results do exist")
        }
        
        taskViewController.dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: Code Needing to Run when view loads
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // MARK: Insert Fxn here for checking document
        
        // MARK: Insert Fxn here for modifying button visibility
        
        theTableView.layer.borderWidth = 1.0
        theTableView.layer.cornerRadius = 5.0
        
        
        
        setupHomeScreen()
        
    
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
//    func getSurveysComplete () -> String {
//
//
//        //var keysValue: String
//
////        let postsRef = db.collection("posts")
////                let query = postsRef.whereField("UID", isEqualTo: Auth.auth().currentUser?.uid)
////                query.getDocuments(){ (querySnapshot, err) in
////                    if let err = err {
////                        print("Error getting documents: \(err)")
////                    } else {
////                        self.numberOfPosts = querySnapshot!.count
////                        print("number of posts: \(self.numberOfPosts)")
////                        for document in querySnapshot!.documents {
////                            let dataDescription = document.data().map(String.init(describing:)).sorted(by: >)
////
////                            print(dataDescription["postScore"])
////                        }
////                    }
////                }
    // MARK: Button Actions
    @IBAction func testButton(_ sender: UIButton) {
        
        getData()
    }
    @IBAction func buttonOneAction(_ sender: UIButton) {
        
        let taskViewController = ORKTaskViewController(task: TaskComponents.showCheckInSurveyTask(), taskRun: nil)
        
        taskViewController.delegate = self
        taskViewController.modalPresentationStyle = .fullScreen
        present(taskViewController, animated: true, completion: nil)
        
        
    }
    
    // MARK: Logic for Buttons
    
    func codeForFindingOnboardingDoc (){
        // listener code for the document
        
        // if found, set isOnboardingComplete = true
        // if not found, set isOnboardingComplete = false
    }
    
    func setupDashboard () {
        // MARK: STATUS: 🔴
        
        if isOnboardingComplete == false {
            // ⚠️ : Hide all survey button elements
            buttonOneO.setTitle("testing Button", for: .normal)
            
        } else {
            // ⚠️ : Show user instructions and onboarding button
            
        }
        
    }
    
    func setupHomeScreen () {
        // MARK: STATUS: 🔴
        
        // ⚠️ : Hide all user instructions and onboarding button
        
        // ⚠️ : Show all survey button element
        
        
        buttonOneO.setTitle("Check In Survey #\(surveysCompleteToDate + 1)", for: .normal)
    }
    
}
