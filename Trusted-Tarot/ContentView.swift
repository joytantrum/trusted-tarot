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
        // tab bar appearance
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .black // Set tab bar background to white

        // unselected item appearance
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = UIColor.white
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        // selected item appearance
        itemAppearance.selected.iconColor = UIColor.blue
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.blue]
        
        // apply the item appearances to the tab bar appearance
        tabBarAppearance.stackedLayoutAppearance = itemAppearance
        tabBarAppearance.inlineLayoutAppearance = itemAppearance
        tabBarAppearance.compactInlineLayoutAppearance = itemAppearance
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance

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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
