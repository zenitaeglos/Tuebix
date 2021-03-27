//
//  TuebixAppApp.swift
//  TuebixApp
//
//  Created by Alejandro Martinez Montero on 20/3/21.
//

import SwiftUI

@main
struct TuebixAppApp: App, NetworkDataDelegate {
    func didReceiveData(fetchedData: Data) {
        print("conseguido \(fetchedData)")
    }
    
    func didOccurrErrorInFetching(_ error: String) {
        
    }
    init() {
        let network = NetworkData()
        network.delegate = self
        network.fetchData(from: "https://www.tuebix.org/2019/giggity.xml")
        print("\(CONFERENCES)")
    }
    
    
    //let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
