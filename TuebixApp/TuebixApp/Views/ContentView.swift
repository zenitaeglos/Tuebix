//
//  ContentView.swift
//  TuebixApp
//
//  Created by Alejandro Martinez Montero on 20/3/21.
//

import SwiftUI
//import CoreData


struct ContentView: View {
    @EnvironmentObject var conferenceInformation: ConferencesViewModel
    //@ObservedObject var conferences: ConferencesViewModel
    var body: some View {
        
        TabView {
            NavigationView {
                List {
                    NavigationLink(destination: CategoryYear(conference: conferenceInformation.conferenceFeatured)) {
                        HStack {
                            Spacer()
                            conferenceInformation.conferenceFeatured.image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 200)
                                .clipped()
                            Spacer()
                        }
                    }
                    
                    CategoryRow(categoryName: "Other Conferences", items: conferenceInformation.conferences)
                }
                .navigationTitle("Linux Conferences")
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .onAppear {
                self.conferenceInformation.setDelegate()
            }.tabItem {
                Label("Conferences", systemImage: "list.dash")
            }
            InformationTab()
                .tabItem {
                    Label("Information", systemImage: "info.circle")
                }
        }
    }
}

/*
struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        List {
            ForEach(items) { item in
                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            #if os(iOS)
            EditButton()
            #endif

            Button(action: addItem) {
                Label("Add Item", systemImage: "plus")
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
*/
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ConferencesViewModel())//.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
