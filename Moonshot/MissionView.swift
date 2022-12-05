//
//  MissionView.swift
//  Moonshot
//
//  Created by Daniel Copley on 12/4/22.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    var mission: Mission
    var crew: [CrewMember]
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            guard let astronaut = astronauts[member.name] else {
                fatalError("Could not find astronaut \(member.name) in astronauts dictionary.")
            }
            return CrewMember(role: member.role, astronaut: astronaut)
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geo.size.width * 0.6)
                        .padding(.top)
                    
                    if let launchDate = mission.formattedLaunchDate {
                        Text(launchDate)
                    }

                    VStack(alignment: .leading) {
                        Capsule()
                            .foregroundColor(.lightBackground)
                            .frame(height: 2)
                        
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                        
                        Capsule()
                            .foregroundColor(.lightBackground)
                            .frame(height: 2)
                        
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(crew, id: \.role) { crewMember in
                                NavigationLink {
                                    AstronautView(astronaut: crewMember.astronaut)
                                } label: {
                                    HStack {
                                        Image(crewMember.astronaut.id)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100)
                                            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                                            .overlay {
                                                RoundedRectangle(cornerRadius: cornerRadius)
                                                    .strokeBorder()
                                                    .foregroundColor(.primary)
                                            }
                                        
                                        VStack(alignment: .leading) {
                                            Text(crewMember.astronaut.name)
                                                .font(.headline)
                                                .foregroundColor(.primary)
                                            
                                            Text(crewMember.role)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    let cornerRadius: CGFloat = 10
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        NavigationStack {
            MissionView(mission: missions.first!, astronauts: astronauts)
                .preferredColorScheme(.dark)
        }
    }
}
