//
//  ReadingsView.swift
//  Trusted-Tarot
//
//  Created by Lindsay Clifford on 5/7/24.
//

import SwiftUI

struct ReadingsData: Identifiable {
    let id = UUID()
    let title: String
    let items: [String]
    let description: [String]
}

struct ReadingsInfo: Identifiable {
    let id = UUID()
    let name: String
    let description: String
}

struct ReadingsView: View {
    @State private var selectedSection: ReadingsData?

        let spreadSections = [
            ReadingsData(title: "head", items: ["Celtic Cross Spread", "Three Card Spread", "Horseshoe Spread"], description: ["Description for Celtic Cross Spread"]),
            ReadingsData(title: "circle-heart", items: ["Relationship Spread"], description: ["Description for Relationship Spread"]),
            ReadingsData(title: "money", items: ["Career Path Spread"], description: ["Description for Career Path Spread"])
        ]
    
    
    
    // Icons corresponding to Readings categories
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                Image("galaxy_2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()

                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(0.7))
                            .frame(width: 380, height: 60)
                            .padding(.horizontal, 0)
                        
                        HStack(spacing: 80) { // spacing between icons
                            ForEach(spreadSections) { section in
                                Button(action: {
                                    selectedSection = section
                                }) {
                                    Image(section.title)
                                        .renderingMode(.template)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(section.title == selectedSection?.title ? .blue : .white)
                                        .shadow(color: Color.gray.opacity(0.5), radius: 3, x: 5, y: 0)
                                }
                            }
                        }
                        .padding(.horizontal, 87) // equal padding on both sides
                    }
                    
                    
                    // Section to navigate to DailyView (Daily Reading)
                    NavigationLink(destination: DailyView()) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white.opacity(0.7))
                                .frame(width: 380, height: 80)
                                .padding(.top, 10) // padding to create space between the two rectangles
                                .padding(.horizontal, 0)
                            
                            HStack {
                                Image(systemName: "stopwatch") // Use an appropriate system image or custom image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 40)
                                
                                VStack(alignment: .leading) {
                                    Text("Daily Reading")
                                        //.font(.headline)
                                        .foregroundColor(.black)
                                    
                                    Text("Get your daily insights")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                .padding(.leading, 10)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 35)
                            }
                        }
                    }
                    
                    Divider()
                    // Displays the selected section
                    if let selectedSection = selectedSection {
                        SpreadView(data: selectedSection.items, cardInfoDictionary: cardInfoDictionary)
                    } else {
                        SpreadView(data: spreadSections.first?.items ?? [], cardInfoDictionary: cardInfoDictionary)
                    }
                }
            }
            .navigationTitle("Learn")
        }
    }
}

// Rows of the list (Card Icon, Spread name, Spread description)
struct SpreadView: View {
    let data: [String]
    let cardInfoDictionary: [String: CardInfo]
    
    var body: some View {
        List(data, id: \.self) { item in
            NavigationLink(destination: CardDetailView(cardInfo: cardInfoDictionary[item])) {
                HStack {
                    Image(cardInfoDictionary[item]?.imageName ?? "card_back")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 80)
                    Text(item)
                }
            }
            //.scrollContentBackground(.hidden)
            .listRowBackground((Color.white).opacity(0.7))
            .cornerRadius(20)
        }
        .scrollContentBackground(.hidden)
        .padding(.horizontal, 0)
        
    }
}

// Individual readings pages (Description, Intention, Layout)
struct ReadingDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    let readingsInfo: ReadingsInfo?
    
    var body: some View {
        ZStack {
            // Galaxy background image
            Image("galaxy_2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Card details
                Text(readingsInfo?.name ?? "Unknown")
                    .font(.custom("Respira-Black", size: 20))
                    .foregroundColor(.white)

                Text(readingsInfo?.description ?? "No description available.")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 15))
                    .foregroundColor(.white)
                    .padding([.leading, .trailing], 70)
                    .padding(.top, 5)

            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.white)
            }
        )
    }
}
    


#Preview {
    ContentView()
}
