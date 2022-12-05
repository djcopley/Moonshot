//
//  ListOrGridViewPopover.swift
//  Moonshot
//
//  Created by Daniel Copley on 12/4/22.
//

import SwiftUI

struct ListOrGridViewPopover: View {
    @Binding var displayMode: DisplayMode
    
    var body: some View {
        VStack {
            switch(displayMode) {
            case .list:
                Button {
                    displayMode = .grid
                } label: {
                    Label("View as Gallery", systemImage: "square.grid.2x2")
                        .labelStyle(.titleAndIcon)
                }
            case .grid:
                Button {
                    displayMode = .list
                } label: {
                    Label("View as List", systemImage: "list.bullet")
                }
            }
        }
    }
}

struct ListOrGridViewPopover_Previews: PreviewProvider {
    @State static var displayMode = DisplayMode.list

    static var previews: some View {
        ListOrGridViewPopover(displayMode: $displayMode)
    }
}
