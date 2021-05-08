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
            Text(talkDetail.description)
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
}

struct BasicTalkDetail_Previews: PreviewProvider {
    static var previews: some View {
        BasicTalkDetail(talkDetail: BasicEventTag(start: "1", duration: "2", room: "3", title: "4", description: "5", persons: ["one"], links: ["one": "two"]))
    }
}
