//
//  ButtonShare.swift
//  TuebixApp
//
//  Created by Alejandro Martinez Montero on 28/4/21.
//

import SwiftUI

struct ButtonShare: View {
    var conferenceName: String
    var titleTalk: String
    var persons: [String]
    var body: some View {
        Button(action: shareContent, label: {
            Image(systemName: "square.and.arrow.up")
        })
    }

    func shareContent() {
        // it shares the content of this specific

        let itemSource = ShareActivityItemSource(conferenceName: conferenceName, title: titleTalk, persons: persons)
        let dataToShare = [itemSource]
        let activityView = UIActivityViewController(activityItems: dataToShare, applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityView, animated: true, completion: nil)
    }
}


class ShareActivityItemSource: NSObject, UIActivityItemSource {
    
    let conference: String
    let title: String
    let persons: [String]
    
    init(conferenceName: String, title: String, persons: [String]) {
        self.conference = conferenceName
        self.title = title
        self.persons = persons
        
        super.init()
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return self.conference
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        if activityType == .postToTwitter {
            return self.title + " #TuebixApp"
        }
        
        var personsString = ""
        for person in self.persons {
            if personsString.count != 0 {
                personsString += ", "
            }
            personsString += person
        }
        
        return "Talk: " + self.title + "\nGiven by: " + personsString
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        return self.conference
    }
    
    
}

struct ButtonShare_Previews: PreviewProvider {
    static var previews: some View {
        ButtonShare(conferenceName: "Tuebix", titleTalk: "nothing", persons: ["me", "you"])
    }
}
