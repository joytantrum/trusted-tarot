//
//  SettingsView.swift
//  Trusted-Tarot
//
//  Created by Lindsay Clifford on 5/7/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Name").background(Color.clear).foregroundStyle(.white)){
                    Text("Lindsay Clifford").background(Color.clear).opacity(0.5)
                }
                Section(header: Text("Email").background(Color.clear).foregroundStyle(.white)){
                    Text("joytantrum@gmail.com").background(Color.clear).opacity(0.5)
                }
                Section(header: Text("Phone number").background(Color.clear).foregroundStyle(.white)){
                    Text("000-000-0000").background(Color.clear).opacity(0.5)
                }
                Section(header: Text("Birthday").background(Color.clear).foregroundStyle(.white)){
                    Text("00/00/0000").background(Color.clear).opacity(0.5)
                }
                Section(header: Text("Notifications").background(Color.clear).foregroundStyle(.white)){
                    Toggle(isOn: .constant(true), label: {
                        Text("Daily digests")
                    })
                    Toggle(isOn: .constant(true), label: {
                        Text("Someone added you")
                    })
                    Toggle(isOn: .constant(true), label: {
                        Text("Someone added you back")
                    })
                    Toggle(isOn: .constant(true), label: {
                        Text("My contact joined")
                    })
                }
            }
            .background(
                Image("galaxy_2")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "arrow.left")
                }
            }
        }
        .scrollContentBackground(.hidden)
    }
}

struct ContentView: View {
    var body: some View {
        MainTabView()
    }
}

#Preview {
    SettingsView()
}
