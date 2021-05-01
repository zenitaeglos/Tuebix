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

    @State private var searchText = ""
    
    @ViewBuilder
    var body: some View {
        SearchBar(text: $searchText)
        if conference.type == "basic" {
            List {
                ForEach(conferenceInformation.conferenceTalksBasicList.filter({ searchText.isEmpty ? true : $0.title.contains(searchText)}), id: \.self) { item in
                    NavigationLink(
                        destination: BasicTalkDetail(talkDetail: item)) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(item.title).font(.headline)
                            HStack {
                                Text("start: " + item.start).font(.subheadline)
                                Text("Room: " + item.room).font(.subheadline)
                            }
                        }
                        .padding([.top, .bottom], 5)
                    }
                }
            }.navigationTitle(conference.title).onAppear {
            self.conferenceInformation.fetchConferenceTalks(from: conference, at: chosenYear)
            }
        }
        
        else if conference.type == "video" {
            List {
                ForEach(self.conferenceInformation.conferenceTalksVideoList.filter({ searchText.isEmpty ? true: $0.title.contains(searchText) }), id: \.self) { item in
                    NavigationLink(destination: VideoTalkDetail(talkDetail: item)) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(item.title).font(.headline)
                            HStack {
                                Text("start: " + item.start).font(.subheadline)
                                Text("Room: " + item.room).font(.subheadline)
                            }
                        }
                        .padding([.top, .bottom], 5)
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
