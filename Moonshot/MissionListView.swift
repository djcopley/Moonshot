//
//  MissionListView.swift
//  Moonshot
//
//  Created by Daniel Copley on 12/4/22.
//

import SwiftUI

struct MissionListView: View {
    var missions: [Mission]
    var astronauts: [String: Astronaut]
    
    var body: some View {
        List {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    HStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                        
                        
                        VStack(alignment: .leading) {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Text(mission.formattedLaunchDate ?? "N/A")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.5))
                        }
                    }
                }
            }
            .listRowBackground(Color.lightBackground)
        }
        .scrollContentBackground(.hidden)
    }
}

struct MissionListView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        NavigationStack {
            MissionListView(missions: missions, astronauts: astronauts)
                .preferredColorScheme(.dark)
                .background(.darkBackground)
        }
    }
}
