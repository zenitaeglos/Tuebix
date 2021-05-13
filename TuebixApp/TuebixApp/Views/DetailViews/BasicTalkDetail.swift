//
//  BasicTalkDetail.swift
//  TuebixApp
//
//  Created by Alejandro Martinez Montero on 3/4/21.
//

import SwiftUI

struct BasicTalkDetail: View {
    var talkDetail: BasicEventTag
    var body: some View {
        ScrollView {
            Text(talkDetail.title)
                .font(.title)
            Divider()
            if talkDetail.persons.count > 0 {
                Text(self.personListToString())
                    .padding()
            }
            Text(talkDetail.description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil))
                .fixedSize(horizontal: false, vertical: true)
            ForEach(talkDetail.links.sorted(by: >), id: \.key) { key, value in
                Link(key, destination: URL(string: value)!).padding()
            }
        }.padding()
        .toolbar {
            ToolbarItem {
                ButtonShare(conferenceName: talkDetail.conferenceName, titleTalk: talkDetail.title, persons: talkDetail.persons)
            }
        }
    }
    
    func personListToString() -> String {
        var personsString = ""
        
        for person in talkDetail.persons {
            if personsString.count != 0 {
                personsString += ", "
            }
            
            personsString += person
        }
        
        if talkDetail.persons.count == 1 {
            personsString = "Speaker: " + personsString
        }
        else if talkDetail.persons.count > 1 {
            personsString = "Speakers: " + personsString
        }
        
        return personsString
    }
    
}

struct BasicTalkDetail_Previews: PreviewProvider {
    static var previews: some View {
        BasicTalkDetail(talkDetail: BasicEventTag(start: "1", duration: "2", room: "3", title: "4", description: "5", persons: ["one"], links: ["one": "two"]))
    }
}
