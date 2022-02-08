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
    
    
    // MARK: 💠 Button outlets 💠
    @IBOutlet weak var buttonOneO: UIButton!
    @IBOutlet var progressBarOutlet: UIView!
    @IBOutlet weak var progresBarHeader: UILabel!
    @IBOutlet weak var theTableView: UITableView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: 💠 Objects With Predetermined Values 💠
    var surveys = [CompletedSurveyItem]()
    var userGroup = [RandomizationGroupStruct]()
    var isOnboardingComplete = false
    var surveysCompleteThisWeek = 0   // Implement listener from firebase here, & have this variable created at signup
    let totalStudySurveys = 24
    var surveysCompleteToDate = 0
    
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
    
    // MARK: 💠 Methods 💠
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async{ self.getData()
            
            // Do any additional setup after loading the view.
            
            // MARK: Insert Fxn here for checking onboarding document
            
            // MARK: Insert Fxn here for modifying button visibility
            self.theTableView.layer.borderWidth = 1.0
            self.theTableView.layer.cornerRadius = 5.0
        }
    }
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        
        let authDB = Auth.auth().currentUser?.uid
        let IPuserUID = "\(authDB!)"
        
        let docTitle = "Survey # \(surveys.count + 1) of 24"
        
        let postResults: [ORKChoiceQuestionResult] = (taskViewController.result.results![3] as! ORKStepResult).results as! [ORKChoiceQuestionResult]
        let preResults: [ORKChoiceQuestionResult] = (taskViewController.result.results![1] as! ORKStepResult).results as! [ORKChoiceQuestionResult]
        
        // If the user makes it to the postSurvey screen, this will populate 20 NULL answers until user selects a new one. This allows the document to be uploaded to the database.
        // Basically this code needs to be triggered if the step is completed so maybe I can drill down to the task and the completion step being reached?
        // MARK: 🟧 I WAS FOCUSED HERE 🟧
            /// I was trying to figure out how to trigger code based on the completion step being reached to prevent a document from being uploaded to the database.
            /// My next problem would be figuring out how to stop the Index 3 or 1 [0...0] out of bounds error.
        if taskViewController.currentStepViewController == taskViewController.task?.step?(withIdentifier: "\(K.TaskIDs.offboardingTaskID).completion") /* OR _currentStepViewController    ORKCompletionStepViewController?    0x000000014002ea00 */   {
            print("We made it to the completion step")
        }
        
        if postResults.isEmpty != true {
        // Layer 2: Verify the randomization group
        TaskComponents.verifyUserGroup(userUID: IPuserUID) { userGroup in
            if let userGroup = userGroup?.groupName {
                
                // layer 3: Randomization group verified, proceed into code that needs to run after finding group
                TaskComponents.verifyDocExist(randomizationGroup: userGroup, userUID: IPuserUID, docTitle: docTitle) { doesExist in
                    if doesExist == false {
                        print(docTitle)
                        
                        // Layer 4: Code dependent on layer 3
                        TaskComponents.createDoc(randomizationGroup: userGroup, userUID: IPuserUID, docTitle: docTitle)
                        
                        
                        
                        // Loop of assigning pre results ID and answer values
                        for result in preResults {
                            let resultIdentifier = "\(result.identifier)"
                            let resultValue = "\(result.answer ?? "null")"
                            
                            // Storing the answers in a looped process
                            TaskComponents.storeCheckInPreSurveyResults(randomizationGroup: userGroup, userUID: IPuserUID, docTitle: docTitle, resultID: resultIdentifier, resultValue: resultValue)
                        }
                        
                        
                        for result in postResults {
                            
                            let resultIdentifier = "\(result.identifier)"
                            let resultValue = "\(result.answer ?? "null")"
                            
                            TaskComponents.storeCheckInPostSurveyResults(randomizationGroup: userGroup, userUID: IPuserUID, docTitle: docTitle, resultID: resultIdentifier, resultValue: resultValue, start: "\(taskViewController.result.startDate)", end: "\(taskViewController.result.endDate)")
                        }
                    } else {
                        print("Does exist, no write made to db")
                    }
                }
                
                
                if taskViewController.result.results != nil {
                    //surveysCompleteToDate += 1
                    print("Not Nil, meaning results do exist")
                }
                
                taskViewController.dismiss(animated: true, completion: self.getData)
            }
        }
        } else {
            taskViewController.dismiss(animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //        return surveysCompleteToDate number of rows
        return self.surveys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "ReusableCellId"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) else {
            return UITableViewCell()
        }
        
        let survey = self.surveys[indexPath.row]
        cell.textLabel?.text = survey.surveyName
        
        var date = survey.endDate
        if let parsed = dfParser.date(from:survey.endDate) {
            date = dfOutputter.string(from:parsed)
        }
        cell.detailTextLabel?.text = date
        return cell
    }
    
    func getData() {
        
        // reference to database
        let db = Firestore.firestore()
        let authDB = Auth.auth().currentUser?.uid
        let IPuserUID = "\(authDB!)"
        
        // Layer 2: Verify the randomization group
        TaskComponents.verifyUserGroup(userUID: IPuserUID) { userGroup in
            if let userGroup = userGroup?.groupName {
                
                // read doc at specific path db.collection("users").getDocuments
                let docRef = db
                    .collection(userGroup)
                    .document(IPuserUID)
                    .collection("Docs for \(IPuserUID)")
                
                docRef.getDocuments { snapshot, error in
                    //documents will be stored in the snapshot parameter in object called document or "d"
                    if error == nil {
                        
                        //no errors means this code will be executed
                        if let snapshot = snapshot {
                            
                            // get all the documents and create an instance of the completedsurveyitem struct
                            DispatchQueue.main.async {
                                
                                self.surveys = snapshot.documents.map { d in // map function iterates through array and performs code on each item and returns a collection
                                    
                                    // return a completedsurveyitem since that's the type of object we want to create
                                    print("ID: \(d.documentID)")
                                    return CompletedSurveyItem(id: d.documentID,
                                                               endDate: d["Task End:"] as? String ?? "",
                                                               surveyName: d["Created"] as? String ?? "")
                                }
                                self.buttonOneO.setTitle("Start Check-in Survey #\(self.surveys.count)", for: .normal)
                                print("Num testSurveys: \(self.surveys.count)")
                                self.tableView.reloadData()
                            }
                        } else{
                            //handle the error
                            print("Error Message: \(error)")
                        }
                    }
                }
            }
        }
    }
    
    func codeForFindingOnboardingDoc (requestedField: String){
        
        // listener code for the document
        TaskComponents.verifyUserGroup(userUID: requestedField) { userGroup in
            if let userGroup = userGroup?.groupName {
                print("This is the user's group \(userGroup)")
                // create the doc from here using another function and the userGroup as an input parameter
            } else
            { print("Value was nil")
            }
            // if found, set isOnboardingComplete = true
            // if not found, set isOnboardingComplete = false
        }
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
    
    // MARK: Button Actions
    @IBAction func testButton(_ sender: UIButton) {
        let authDB = Auth.auth().currentUser?.uid
        let IPuserUID = "\(authDB!)"
        
        TaskComponents.verifyUserGroup(userUID: IPuserUID) { userGroup in
            if let userGroup = userGroup?.groupName {
                print("This is the user's group \(userGroup)")
                // create the doc from here using another function and the userGroup as an input parameter
            } else
            { print("Value was nil")
            }
            
        }
        
    }
    
    @IBAction func buttonOneAction(_ sender: UIButton) {
        
        let taskViewController = ORKTaskViewController(task: TaskComponents.showCheckInSurveyTask(), taskRun: nil)
        
        taskViewController.delegate = self
        taskViewController.modalPresentationStyle = .fullScreen
        present(taskViewController, animated: true, completion: nil)
    }
}
