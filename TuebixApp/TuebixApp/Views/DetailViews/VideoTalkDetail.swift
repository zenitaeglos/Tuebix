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
            Text(talkDetail.description)
            
            VideoPlayer(player: AVPlayer(url: URL(string: self.urlForVideo())!))
                .frame(height: 400)
        }.padding()
    }
    
    func urlForVideo() -> String {
        guard let urlLink = self.talkDetail.links["Video recording (mp4)"] else { return "" }
        
        
        return urlLink
    }
}

struct VideoTalkDetail_Previews: PreviewProvider {
    static var previews: some View {
        VideoTalkDetail(talkDetail: VideoEventTag(start: "1", duration: "2", room: "3", title: "4", subtitle: "5", track: "6", abstract: "asd", description: "asd", persons: ["ad"], links: ["ad": "add"]))
    }
}
