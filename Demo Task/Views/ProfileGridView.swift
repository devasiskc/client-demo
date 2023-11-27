//
//  Profile View.swift
//  Demo Task
//
//  Created by Devasis KC on 26/11/2023.
//

import SwiftUI
import MapKit

struct ProfileGridView: View {
    
    @StateObject private var viewModel = DemoViewModel()
    
    let profiles: [ProfileView] = [
        ProfileView(name: "Devasis KC", location: "6 Bolger Pl, Booragoon, Western Australia", profileImage: "profileImage"),
        ProfileView(name: "Arlian Lama", location: "6 Bolger Pl, Booragoon, Western Australia", profileImage: "profileImage1"),
        ProfileView(name: "Neela Rai", location: "6 Bolger Pl, Booragoon, Western Australia", profileImage: "profileImage2"),
        ProfileView(name: "Anil Gurung", location: "6 Bolger Pl, Booragoon, Western Australia", profileImage: "profileImage3")
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 16) {
                    ForEach(profiles) { profile in
                        NavigationLink(destination: ProfileDetailView(profile: profile)) {
                            ProfileCard(profile: profile)
                        }
                    }
                }
                .padding()
                Text("Example of an RestAPI data fetching through Generic API Service Class")
                    .padding()
                VStack {
                    if let data = viewModel.data {
                        Text(data.title)
                            .font(.headline)
                        Text(data.body)
                            .font(.footnote)
                        Button {
                            //call func
                        } label: {
                            Text(String(stringLiteral: "Read More"))
                            
                        }
                        
                        
                    } else {
                        ProgressView("Loading data")
                    }
                }
            }
            .task {
                // await viewModel.fetchData()
                //viewModel.fetchData1()
                await viewModel.fetchDataGeneric()
                
            }
            }
            .navigationTitle("Profiles")
            .padding()
    }
}

struct ProfileCard: View {
    var profile: ProfileView
    
    var body: some View {
        VStack(alignment: .center) {
            Image(uiImage: UIImage(named: profile.profileImage)!)
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 50, height: 50)
              .clipShape(Circle())
              .overlay(Circle().stroke(Color("fig"), lineWidth: 1))
            Text(profile.name)
                .font(.headline)
            Text(profile.location)
                .foregroundColor(.secondary)
                .font(.subheadline)
            
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileGridView()
    }
}

