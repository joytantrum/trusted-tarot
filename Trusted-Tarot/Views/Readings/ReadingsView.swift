//
//  ReadingsView.swift
//  Trusted-Tarot
//
//  Created by Lindsay Clifford on 5/7/24.
//

import SwiftUI

struct ReadingsView: View {
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Image("galaxy_2")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
            .navigationTitle("Readings")
            .edgesIgnoringSafeArea(.all)
        }
    }
}


#Preview {
    ReadingsView()
}
