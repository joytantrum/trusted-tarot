//
//  ContentView.swift
//  Trusted-Tarot
//
//  Created by Lindsay Clifford on 5/7/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            DailyView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Daily")
                }
            
            ReadingsView()
                .tabItem {
                    Image(systemName: "eye")
                    Text("Readings")
                }
            
            LearnView()
                .tabItem {
                    Image(systemName: "book")
                    Text("Learn")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
            
        }
        .accentColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
