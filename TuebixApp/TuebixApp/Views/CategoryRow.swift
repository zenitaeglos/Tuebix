//
//  CategoryRow.swift
//  TuebixApp
//
//  Created by Alejandro Martinez Montero on 3/4/21.
//

import SwiftUI

struct CategoryRow: View {
    var categoryName: String
    var items: [Conference]
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(items, id: \.self) { item in
                        NavigationLink(
                            destination: CategoryYear(conference: item)) {
                            CategoryItem(conference: item)
                        }
                    }
                }
            }
            .frame(height: 185)
        }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow(categoryName: "One", items: [
            Conference(title: "Tuebix", type: "basic", years: [2016, 2017, 2018, 2019], basicURL: "https://tuebix.org/", endURL: "giggity.xml", imageName: "play.rectangle.fill"),
            Conference(title: "Fosdem", type: "video", years: [2016, 2017, 2018, 2019, 2020, 2021], basicURL: "https://fosdem.com", endURL: "/schedule/xml", imageName: "play.circle.fill")
        ])
    }
}
