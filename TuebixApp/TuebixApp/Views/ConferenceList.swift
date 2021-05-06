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
                ForEach(self.sectionsForRooms(type: "basic"), id: \.self) { room in
                    Section(header: Text(room)) {
                        ForEach(conferenceInformation.conferenceTalksBasicList.filter({ searchText.isEmpty ? true : $0.title.contains(searchText)}).filter({ $0.room == room }).sorted(by: { ($0.day, $0.start) < ($1.day, $1.start)}), id: \.self) { item in
                            NavigationLink(
                                destination: BasicTalkDetail(talkDetail: item)) {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(item.title).font(.headline)
                                    HStack {
                                        Text("start: " + item.start).font(.subheadline)
                                        Text("Day: " + item.day).font(.subheadline)
                                    }
                                }
                                .padding([.top, .bottom], 5)
                            }
                        }
                    }
                }
                /*
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
                */
            }.navigationTitle(conference.title).onAppear {
            self.conferenceInformation.fetchConferenceTalks(from: conference, at: chosenYear)
            }
        }
        
        else if conference.type == "video" {
            List {
                ForEach(self.sectionsForRooms(type: "video"), id: \.self) { room in
                    Section(header: Text(room)) {
                        ForEach(self.conferenceInformation.conferenceTalksVideoList.filter({ searchText.isEmpty ? true: $0.title.contains(searchText) }).filter({ $0.room == room }).sorted(by: { ($0.day, $0.start) < ($1.day, $1.start)}), id: \.self) { item in
                            NavigationLink(destination: VideoTalkDetail(talkDetail: item)) {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(item.title).font(.headline)
                                    HStack {
                                        Text("start: " + item.start).font(.subheadline)
                                        Text("Day: " + item.day).font(.subheadline)
                                    }
                                }
                                .padding([.top, .bottom], 5)
                            }
                        }
                    }
                }
                /*
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
                */
            }.navigationTitle(conference.title).onAppear {
                self.conferenceInformation.fetchConferenceTalks(from: conference, at: chosenYear)
            }
        }
    }
    
    func sectionsForRooms(type name: String) -> [String] {
        var sections: [String] = []
        if name == "basic" {
            for talk in conferenceInformation.conferenceTalksBasicList {
                if !sections.contains(talk.room) {
                    sections.append(talk.room)
                }
            }
        }
        else if name == "video" {
            for talk in conferenceInformation.conferenceTalksVideoList {
                if !sections.contains(talk.room) {
                    sections.append(talk.room)
                }
            }
        }

        return sections
    }
}

struct ConferenceList_Previews: PreviewProvider {
    static var previews: some View {
        ConferenceList(conference: Conference(title: "Tuebix", type: "basic", years: [2016, 2017, 2018, 2019], basicURL: "https://tuebix.org/", endURL: "giggity.xml", imageName: "play.rectangle.fill"), chosenYear: 2019)
    }
}
