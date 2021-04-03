//
//  ConferenceList.swift
//  TuebixApp
//
//  Created by Alejandro Martinez Montero on 3/4/21.
//

import SwiftUI


struct ConferenceList: View {
    @EnvironmentObject var conferenceInformation: ConferencesViewModel
    var conference: Conference
    var chosenYear: Int

    
    @ViewBuilder
    var body: some View {
        if conference.type == "basic" {
            NavigationView {
                List {
                    ForEach(conferenceInformation.conferenceTalksBasicList, id: \.self) { item in
                        NavigationLink(
                            destination: BasicTalkDetail()) {
                                Text(item.title)
                            }
                    }
                }
            }.onAppear {
                self.conferenceInformation.fetchConferenceTalks()
            }
        }
        
        else if conference.type == "video" {
            NavigationView {
                List {
                    ForEach(["pato", "vaca"], id: \.self) { item in
                        Text(item)
                    }
                }
            }
        }
    }
}

struct ConferenceList_Previews: PreviewProvider {
    static var previews: some View {
        ConferenceList(conference: Conference(title: "Tuebix", type: "basic", years: [2016, 2017, 2018, 2019], basicURL: "https://tuebix.org/", endURL: "giggity.xml", imageName: "play.rectangle.fill"), chosenYear: 2019)
    }
}
