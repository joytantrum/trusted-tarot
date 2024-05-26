//
//  ContentView.swift
//  Trusted-Tarot
//
//  Created by Lindsay Clifford on 5/7/24.
//

import SwiftUI



struct MainTabView: View {
    @State private var selectedTab = 0
    
    init() {
        // Customize tab bar appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.black // Set background color to black
        UITabBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            DailyView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Daily")
                }
                .tag(0)
            
            ReadingsView()
                .tabItem {
                    Image(systemName: "eye")
                    Text("Readings")
                }
                .tag(1)
            
            LearnView()
                .tabItem {
                    Image(systemName: "book")
                    Text("Learn")
                }
                .tag(2)
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .tag(3)
        }
        .accentColor(selectedTab == 2 ? .blue : .white) // changes accent color based on selected tab
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
