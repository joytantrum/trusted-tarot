//
//  HomeView.swift
//  Trusted-Tarot
//
//  Created by Lindsay Clifford on 5/7/24.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                       ZStack {
                           Image("galaxy_2")
                               .resizable()
                               .aspectRatio(contentMode: .fill)
                               .frame(width: geometry.size.width, height: geometry.size.height)
                           Color.clear.overlay(
                               VStack(alignment: .center, spacing: 10) {
                                   
                                   Image("logo")
                                       .resizable()
                                       .aspectRatio(contentMode: .fit)
                                       .frame(width: 250, height: 100)
                                       .padding(0)
                                       .padding(.top, 250)
                                       
                                   Text("Trusted Tarot").font(.custom("Respira-Black", size: 40))
                                       .fontWeight(.semibold)
                                       .foregroundColor(.white)
                                       .multilineTextAlignment(.center)
                                       .padding(.bottom, 0)
                                       
                                   
                                   Text("Precise divination at your fingertips, offering guidance wherever you roam.")
                                       .font(.system(size: 17))
                                       .font(.largeTitle)
                                       .fontWeight(.thin)
                                       .foregroundColor(.white)
                                       .multilineTextAlignment(.center)
                                     
                                       .padding([.leading, .trailing], 30)
                                   
                                       Spacer()
                               }
                               .frame(maxWidth: .infinity, maxHeight: .infinity)
                           )
                       }
                   }
                    .navigationTitle("Home")
                    .navigationBarHidden(true)
                    .edgesIgnoringSafeArea(.all)
        }
    }
}
#Preview {
    HomeView()
}
