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

let CONFERENCEFEATURED = Conference(title: "Tuebix", type: "basic", years: [2016, 2017, 2018, 2019], basicURL: "https://www.tuebix.org/", endURL: "/giggity.xml", imageName: "tuebix-logo")



let CONFERENCES: [Conference] = [
    //Conference(title: "Fosdem", type: "video", years: [2016, 2017, 2018, 2019, 2020, 2021, 2022], basicURL: "https://fosdem.org/", endURL: "/schedule/xml", imageName: "fosdem-logo"),
    Conference(title: "Fosdem", type: "video", years: [2016, 2017, 2018, 2019, 2020, 2021], basicURL: "https://fosdem.org/", endURL: "/schedule/xml", imageName: "fosdem-logo"),
    Conference(title: "Froscon", type: "basic", years: [2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022], basicURL: "https://programm.froscon.de/", endURL: "/schedule.xml", imageName: "froscon-logo"),
    Conference(title: "Open South Code", type: "basic", years: [2016, 2017, 2018, 2019], basicURL: "https://www.opensouthcode.org/conferences/opensouthcode", endURL: "/schedule.xml", imageName: "osc-logo"),
    Conference(title: "Capitole du libre", type: "basic", years: [2018, 2019], basicURL: "https://participez-", endURL: ".capitoledulibre.org/schedule/xml/", imageName: "capitole-du-libre")
]


