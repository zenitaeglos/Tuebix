//
//  CategoryYear.swift
//  TuebixApp
//
//  Created by Alejandro Martinez Montero on 3/4/21.
//

import SwiftUI

struct CategoryYear: View {
    @EnvironmentObject var conferencesInformation: ConferencesViewModel
    var conference: Conference
    var body: some View {
        HStack(alignment: .top, spacing: 2) {
            List {
            ForEach(conference.years, id: \.self) { year in
                NavigationLink(destination: ConferenceList(conference: conference, chosenYear: year)) {
                    Text(String(year))
                }
            }
        }
        }.navigationTitle(conference.title)
        .onAppear {
            self.conferencesInformation.setCurrentConference(from: conference)
        }
    }
}

struct CategoryYear_Previews: PreviewProvider {
    static var previews: some View {
        CategoryYear(conference: Conference(title: "Tuebix", type: "basic", years: [2016, 2017, 2018, 2019], basicURL: "https://tuebix.org/", endURL: "giggity.xml", imageName: "play.rectangle.fill"))
    }
}
