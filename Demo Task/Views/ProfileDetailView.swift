//
//  ProfileDetailView.swift
//  Demo Task
//
//  Created by Devasis KC on 26/11/2023.
//
import SwiftUI

struct ProfileDetailView: View {
    var profile: ProfileView
    
    var body: some View {
        VStack {
            
            Image("\(profile.profileImage)")
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 120, height: 120)
              .clipShape(Circle())
              .overlay(Circle().stroke(Color("fig"), lineWidth: 1))
            
            Text("\(profile.location)")
                .font(.title)
            
            Spacer()
            
            MapView(location: profile.location)
                .frame(height: 300)
        }
        .padding()
        .navigationTitle(profile.name)
    }
}
