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
            List {
                ForEach(conferenceInformation.conferenceTalksBasicList, id: \.self) { item in
                    NavigationLink(
                        destination: BasicTalkDetail(talkDetail: item)) {
                            Text(item.title)
                        }
                }
            }.navigationTitle(conference.title).onAppear {
            self.conferenceInformation.fetchConferenceTalks(from: conference, at: chosenYear)
            }
        }
        
        else if conference.type == "video" {
            List {
                ForEach(self.conferenceInformation.conferenceTalksVideoList, id: \.self) { item in
                    NavigationLink(destination: VideoTalkDetail(talkDetail: item)) {
                            Text(item.title)
                    }
                }
            }.navigationTitle(conference.title).onAppear {
                self.conferenceInformation.fetchConferenceTalks(from: conference, at: chosenYear)
            }
        }
    }
}

struct ConferenceList_Previews: PreviewProvider {
    static var previews: some View {
        ConferenceList(conference: Conference(title: "Tuebix", type: "basic", years: [2016, 2017, 2018, 2019], basicURL: "https://tuebix.org/", endURL: "giggity.xml", imageName: "play.rectangle.fill"), chosenYear: 2019)
    }
}
