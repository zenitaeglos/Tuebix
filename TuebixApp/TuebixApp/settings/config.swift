//
//  config.swift
//  TuebixApp
//
//  Created by Alejandro Martinez Montero on 26/3/21.
//

import Foundation


struct Conferences {
    let title: String
    let type: String
    let years: [Int]
    let basicURL: String
}



let CONFERENCES: Dictionary<String, Conferences> = ["Tuebix": Conferences(title: "tuebix", type: "basic", years: [2016, 2017, 2018, 019], basicURL: "https://tuebix.org/")]


