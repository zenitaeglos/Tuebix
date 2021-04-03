//
//  TuebixAppApp.swift
//  TuebixApp
//
//  Created by Alejandro Martinez Montero on 20/3/21.
//

import SwiftUI


//let conference = CONFERENCES["Tuebix"]

@main
struct TuebixAppApp: App, NetworkDataDelegate {
    func didReceiveData(fetchedData: Data) {
        //let x = ConferenceParser(data: fetchedData, type: "basic")
        //x.printAll()
    }
    
    func didOccurrErrorInFetching(_ error: String) {
        
    }
    init() {
        let network = NetworkData()
        network.delegate = self
        network.fetchData(from: "https://www.tuebix.org/2019/giggity.xml")
        //network.fetchData(from: "https://fosdem.org/2020/schedule/xml")
        //print("\(CONFERENCES)")
    }
    
    
    //let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(ConferencesViewModel())
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
