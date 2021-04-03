//
//  config.swift
//  TuebixApp
//
//  Created by Alejandro Martinez Montero on 26/3/21.
//

import Foundation
import SwiftUI


struct Conference: Hashable {
    let title: String
    let type: String
    let years: [Int]
    let basicURL: String
    let endURL: String
    let imageName: String
    var image: Image {
        Image(imageName)
    }
}

let CONFERENCEFEATURED = Conference(title: "Tuebix", type: "basic", years: [2016, 2017, 2018, 2019], basicURL: "https://www.tuebix.org/", endURL: "/giggity.xml", imageName: "play.rectangle.fill")



let CONFERENCES: [Conference] = [
    Conference(title: "Fosdem", type: "video", years: [2016, 2017, 2018, 2019, 2020, 2021], basicURL: "https://fosdem.org/", endURL: "/schedule/xml", imageName: "play.circle.fill"),
    Conference(title: "Froscon", type: "basic", years: [2015, 2016, 2019], basicURL: "https://programm.froscon.de/", endURL: "/schedule.xml", imageName: "play.circle.fill")
]


