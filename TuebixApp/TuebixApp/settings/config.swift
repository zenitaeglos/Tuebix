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
    
}



let CONFERENCES: [Conferences] = [
    Conferences(title: "tuebix", type: "basic", years: [2016, 2017, 2018, 2019])
]

