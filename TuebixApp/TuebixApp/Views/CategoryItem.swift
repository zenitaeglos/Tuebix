//
//  CategoryItem.swift
//  TuebixApp
//
//  Created by Alejandro Martinez Montero on 3/4/21.
//

import SwiftUI

struct CategoryItem: View {
    var conference: Conference
    var body: some View {
        VStack(alignment: .leading) {
            conference.image
                .resizable()
                .frame(width: 155, height: 155)
                .cornerRadius(5)
            Text(conference.title)
                .font(.caption)
        }
        .padding(.leading, 15)
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(conference: Conference(title: "Tuebix", type: "basic", years: [2016, 2017, 2018, 2019], basicURL: "https://tuebix.org/", endURL: "giggity.xml", imageName: "play.rectangle.fill"))
    }
}
