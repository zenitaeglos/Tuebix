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
                Button(action: shareContent, label: {
                    Image(systemName: "square.and.arrow.up")
                })
            }
        }
    }
    
    func shareContent() {
        // it shares the content of this specific
        //talk to other applications
        var dataToShare = ["Look at this talk, it looks interesting"]
        dataToShare.append(talkDetail.title)
        let activityView = UIActivityViewController(activityItems: dataToShare, applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityView, animated: true, completion: nil)
    }
}

struct BasicTalkDetail_Previews: PreviewProvider {
    static var previews: some View {
        BasicTalkDetail(talkDetail: BasicEventTag(start: "1", duration: "2", room: "3", title: "4", description: "5", persons: ["one"], links: ["one": "two"]))
    }
}
