//
//  VideoTalkDetail.swift
//  TuebixApp
//
//  Created by Alejandro Martinez Montero on 3/4/21.
//

import SwiftUI
import AVKit

struct VideoTalkDetail: View {
    var talkDetail: VideoEventTag
    var body: some View {
        ScrollView {
            Text(talkDetail.title).font(.title)
            Text(talkDetail.subtitle).font(.title2)
            Divider()
            if talkDetail.persons.count > 0 {
                Text(self.personListToString())
                    .padding()
            }

            Text(talkDetail.description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil))
                .fixedSize(horizontal: false, vertical: true)
            
            if isVideo() {
                VideoPlayer(player: AVPlayer(url: URL(string: self.urlForVideo())!))
                    .frame(height: 400)

            }
            ForEach(talkDetail.links.sorted(by: >), id: \.key) { key, value in
                if !key.contains("Video recording") {
                    Link(key, destination: URL(string: value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")!).padding()

                }

            }
        }.padding()
        .toolbar {
            ToolbarItem {
                ButtonShare(conferenceName: talkDetail.conferenceName, titleTalk: talkDetail.title, persons: talkDetail.persons)
                //ButtonShare(descriptionToShare: talkDetail.title)
            }
        }
    }
    
    func isVideo() -> Bool {
        print(talkDetail)
        
        for (key, _) in self.talkDetail.links {
            if key.lowercased().replacingOccurrences(of: " ", with: "").contains("videorecording(mp4)") {
                
                return true
            }
        }
        return false
    }
    
    func urlForVideo() -> String {
        var urlLink = ""
        for (key, value) in self.talkDetail.links {
            if key.lowercased().replacingOccurrences(of: " ", with: "").contains("videorecording(mp4)") {
                urlLink = value
            }
        }
        return urlLink
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

struct VideoTalkDetail_Previews: PreviewProvider {
    static var previews: some View {
        VideoTalkDetail(talkDetail: VideoEventTag(start: "1", duration: "2", room: "3", title: "4", subtitle: "5", track: "6", abstract: "asd", description: "asd", persons: ["ad", "second"], links: ["ad": "add"]))
    }
}
