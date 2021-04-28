//
//  ButtonShare.swift
//  TuebixApp
//
//  Created by Alejandro Martinez Montero on 28/4/21.
//

import SwiftUI

struct ButtonShare: View {
    var descriptionToShare: String
    var body: some View {
        Button(action: shareContent, label: {
            Image(systemName: "square.and.arrow.up")
        })
    }

    func shareContent() {
        // it shares the content of this specific
        //talk to other applications
        var dataToShare = ["Look at this talk, it looks interesting\n"]
        dataToShare.append(descriptionToShare)
        let activityView = UIActivityViewController(activityItems: dataToShare, applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityView, animated: true, completion: nil)
    }
}

struct ButtonShare_Previews: PreviewProvider {
    static var previews: some View {
        ButtonShare(descriptionToShare: "Look at this cool talk")
    }
}
