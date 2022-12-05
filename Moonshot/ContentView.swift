//
//  ContentView.swift
//  Moonshot
//
//  Created by Daniel Copley on 12/1/22.
//

import SwiftUI
import Popovers

enum DisplayMode: String {
    case grid, list
}

struct ContentView: View {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    @AppStorage("displayMode") private var displayMode = DisplayMode.grid
        
    var body: some View {
        NavigationStack {
            Group {
                switch(displayMode) {
                case .grid: MissionGridView(missions: missions, astronauts: astronauts)
                case .list: MissionListView(missions: missions, astronauts: astronauts)
                }
            }
            .navigationTitle("Moonshot")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Picker(selection: $displayMode, label: Text("Sorting options")) {
                            Label("View as Gallery", systemImage: "square.grid.2x2").tag(DisplayMode.grid)
                            Label("View as List", systemImage: "list.bullet").tag(DisplayMode.list)
                        }
                    } label: {
                        Label("Options", systemImage: "ellipsis.circle")
                    }
                }
            }
            .background(.darkBackground)
        }
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
