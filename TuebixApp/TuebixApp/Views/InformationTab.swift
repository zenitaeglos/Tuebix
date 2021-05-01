//
//  InformationTab.swift
//  TuebixApp
//
//  Created by Alejandro Martinez Montero on 1/5/21.
//

import SwiftUI

struct InformationTab: View {
    var body: some View {
        VStack {
            Link(destination: URL(string: "https://github.com/zenitaeglos/Tuebix")!) {
                Image("tuebix-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }.frame(alignment: .top)
            .padding(.top, 40)
            Spacer()
            Text("App created by\nAlejandro Martinez")
            Spacer()
        }.padding()
    }
}

struct InformationTab_Previews: PreviewProvider {
    static var previews: some View {
        InformationTab()
    }
}
