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
    
    var currentConference: Conference?
    
    @Published var conferenceTalksList: [EventTag]
    @Published var conferenceTalksBasicList: [BasicEventTag]
    @Published var conferenceTalksVideoList: [VideoEventTag]
    @Published var isFetchError: Bool
    @Published var fetchErrorInformation: String
    
    
    let network: NetworkData
        
    
    init() {
        self.network = NetworkData()
        self.conferenceTalksList = [BasicEventTag]()
        self.conferenceTalksBasicList = [BasicEventTag]()
        self.conferenceTalksVideoList = [VideoEventTag]()
        self.isFetchError = false
        self.fetchErrorInformation = String()
        self.currentConference = nil
    }
    
    
    func setDelegate() {
        self.network.delegate = self
    }
    
    func setCurrentConference(from conference: Conference) {
        self.currentConference = conference
        // set the current conference chosen in the UI
    }
    
    func fetchConferenceTalks() {
        //self.network.fetchData(from: "https://www.tuebix.org/2019/giggity.xml")
        //self.network.fetchData(from: "https://fosdem.org/2021/schedule/xml")
    }
    
    func fetchConferenceTalks(from conference: Conference, at year: Int) {
        //print(conference)
        //print(conference.basicURL + String(year) + conference.endURL)
        self.network.fetchData(from: conference.basicURL + String(year) + conference.endURL)
    }
    
    // delete all the lists, as we leave the list view, to give a new search possibility
    // eliminate unncessesary lists
    func deleteConferenceLists() {
        self.conferenceTalksBasicList.removeAll()
        self.conferenceTalksVideoList.removeAll()
        self.fetchErrorInformation = String()
    }
}



extension ConferencesViewModel: NetworkDataDelegate {
    func didReceiveData(fetchedData: Data) {
        let x = ConferenceParser(data: fetchedData, type: self.currentConference?.type ?? "basic")
        //x.printAll()
        //var myType = "basic"
        switch self.currentConference?.type {
        case "basic":
            self.conferenceTalksBasicList = x.allTalks() as! [BasicEventTag]
        case "video":
            self.conferenceTalksVideoList = x.allTalks() as! [VideoEventTag]
        default:
            self.conferenceTalksList = x.allTalks()
        }
        //self.conferenceTalksBasicList = x.allTalks() as! [BasicEventTag]
        
        
        //self.conferenceTalksBasicList = x.allBasicTalks()
        //self.conferenceTalksList = x.allTalks() as [BasicEventTag]
    }
    
    func didOccurrErrorInFetching(_ error: String) {
        print("there was an error")
        print(error)
        self.isFetchError = true
        self.fetchErrorInformation = error
    }
    
    
}
