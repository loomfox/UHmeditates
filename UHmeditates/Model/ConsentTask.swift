//
//  ConsentTask.swift
//  UHmeditates
//
//  Created by Tyler Boston on 8/3/21.
//

import Foundation
import ResearchKit

public var ConsentTask: ORKOrderedTask {
    
    func oldCode() {
        let sectionTypes: [ORKConsentSectionType] = [
            .overview,
            .dataGathering,
            .privacy,
            .dataUse,
            .timeCommitment,
            .studySurvey,
            .studyTasks,
            .withdrawing
        ]
        
        let consentSections: [ORKConsentSection] = sectionTypes.map { contentSectionType in
            // a for in loop is ran here to allow the sections to be quickly generated with the same generic info
            let consentSection = ORKConsentSection(type: contentSectionType)
            consentSection.summary = "Complete the study"
            consentSection.content = "This survey will ask you three questions and you will also measure your tapping speed by performing a small activity."
            return consentSection
        }
    }
    
    // Consent Sections (8)
    let consentSection1 = ORKConsentSection(type: .overview)
    consentSection1.title = "Study Overview"
    consentSection1.summary = "Brief sentence"
    consentSection1.content = "Long description"
    
    let consentSection2 = ORKConsentSection(type: .dataGathering)
    consentSection2.title = "Meditation Time"
    consentSection2.summary = "Brief sentence"
    consentSection2.content = "Long description"
    
    let consentSection3 = ORKConsentSection(type: .privacy)
    consentSection3.title = "Privacy"
    consentSection3.summary = "Brief sentence"
    consentSection3.content = "Long description"
    
    let consentSection4 = ORKConsentSection(type: .dataUse)
    consentSection4.title = "How Your Data is Used"
    consentSection4.summary = "Brief sentence"
    consentSection4.content = "Long description"
    
    let consentSection5 = ORKConsentSection(type: .timeCommitment)
    consentSection5.title = "Time Commitment"
    consentSection5.summary = "Brief sentence"
    consentSection5.content = "Long description"
    
    let consentSection6 = ORKConsentSection(type: .studySurvey)
    consentSection6.title = "Surveys"
    consentSection6.summary = "Brief sentence"
    consentSection6.content = "Long description"
    
    let consentSection7 = ORKConsentSection(type: .studyTasks)
    consentSection7.title = "Tasks"
    consentSection7.summary = "Brief sentence"
    consentSection7.content = "Long description"
    
    let consentSection8 = ORKConsentSection(type: .withdrawing)
    consentSection8.title = "Withdrawing From the Study"
    consentSection8.summary = "Brief sentence"
    consentSection8.content = "Long description"
    
    let consentSectionsArray = [consentSection1,
                                consentSection2,
                                consentSection3,
                                consentSection4,
                                consentSection5,
                                consentSection6,
                                consentSection7,
                                consentSection8]
   
    // Creation of Visual Consent Document
    let consentDocument = ORKConsentDocument()
    consentDocument.title = "Test Consent"
    consentDocument.sections = consentSectionsArray
    consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "UserSignature"))
    
    // Adding Review Section
    var steps = [ORKStep]()
    
    //Visual Consent
    let visualConsentStep = ORKVisualConsentStep(identifier: "VisualConsent", document: consentDocument)
    steps += [visualConsentStep]
    
    //Signature
    let signature = consentDocument.signatures!.first! as ORKConsentSignature
    let reviewConsentStep = ORKConsentReviewStep(identifier: "Review", signature: signature, in: consentDocument)
    reviewConsentStep.text = "Review the consent"
    reviewConsentStep.reasonForConsent = "Consent to join the Research Study."
    
    steps += [reviewConsentStep]
    
    //Completion
    let completionStep = ORKCompletionStep(identifier: "CompletionStep")
    completionStep.title = "Welcome"
    completionStep.text = "Thank you for joining this study."
    steps += [completionStep]
    
    return ORKOrderedTask(identifier: "ConsentTask", steps: steps)
}
