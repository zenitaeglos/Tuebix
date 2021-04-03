//
//  ConferencesViewModel.swift
//  TuebixApp
//
//  Created by Alejandro Martinez Montero on 2/4/21.
//

import Foundation



class ConferencesViewModel: ObservableObject {
    var conferences = CONFERENCES
    var conferenceFeatured = CONFERENCEFEATURED
    
    @Published var conferenceTalksList: [BasicEventTag]
    @Published var conferenceTalksBasicList: [BasicEventTag]
    @Published var conferenceTalksVideoList: [VideoEventTag]
    
    
    let network: NetworkData
        
    
    init() {
        self.network = NetworkData()
        self.conferenceTalksList = [BasicEventTag]()
        self.conferenceTalksBasicList = [BasicEventTag]()
        self.conferenceTalksVideoList = [VideoEventTag]()
    }
    
    
    func setDelegate() {
        print("setting the delegate")
        self.network.delegate = self
    }
    
    func fetchConferenceTalks() {
        self.network.fetchData(from: "https://www.tuebix.org/2019/giggity.xml")
        //self.network.fetchData(from: "https://fosdem.org/2021/schedule/xml")
    }
}



extension ConferencesViewModel: NetworkDataDelegate {
    func didReceiveData(fetchedData: Data) {
        let x = ConferenceParser(data: fetchedData, type: "basic")
        x.printAll()
        var myType = "basic"
        self.conferenceTalksBasicList = x.allTalks() as! [BasicEventTag]
        
        
        //self.conferenceTalksBasicList = x.allBasicTalks()
        //self.conferenceTalksList = x.allTalks() as [BasicEventTag]
    }
    
    func didOccurrErrorInFetching(_ error: String) {
        
    }
    
    
}
