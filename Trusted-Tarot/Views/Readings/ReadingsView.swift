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
    //  state variable to keep track of the selected reading
    @State private var selectedReading: ReadingsData?
        // array of ReadingsData objects that represent different reading sections
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
                        
                        HStack(spacing: 80) {                          // spacing between icons
                            ForEach(spreadSections) { section in       // iterates over spreadSections to create a button for each section
                                Button(action: {
                                    selectedReading = section          // when pressed, updates selectedReading
                                }) {
                                    Image(section.title)               // displays an image (assuming the image names match the titles).
                                        .renderingMode(.template)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(section.title == selectedReading?.title ? .blue : .white)
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
                                .padding(.top, 10)                  // padding to create space between the two rectangles
                                .padding(.horizontal, 0)
                            
                            HStack {
                                Image(systemName: "stopwatch")      // Use an appropriate system image or custom image
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
                    // Displays the selected section (conditionally unwraps selectedReading)
                    // Displays the selected section
                    if let selectedSection = selectedReading {
                        SpreadView(data: selectedSection.items, readingsInfoDictionary: readingsInfoDictionary)
                    } else {
                        SpreadView(data: spreadSections.first?.items ?? [], readingsInfoDictionary: readingsInfoDictionary)
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
    let readingsInfoDictionary: [String: ReadingsInfo]

    var body: some View {
        List {
            ForEach(data, id: \.self) { item in
                if let readingInfo = readingsInfoDictionary[item] {
                    NavigationLink(destination: ReadingDetailView(readingsInfo: readingInfo)) {
                        HStack(alignment: .center, spacing: 10) {
                            Image("cards") // Ensure you have correct image names in readingsInfo
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30) // Smaller frame dimensions
                            

                            VStack(alignment: .leading, spacing: 5) {
                                Text(readingInfo.name)
                                    //.font(.headline)
                                    .foregroundColor(.primary)
                                Text(readingInfo.description)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .lineLimit(2) // Limit description to 2 lines
                            }
                            .padding(.leading, 5)
                        }
                        .padding()
                        //.background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.4))) // Background for the entire HStack
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5) // Shadow for the HStack
                    }
                    .padding(.vertical, 5)
                    .listRowBackground(Color.white.opacity(0.7)) // Ensure each row's background is clear
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.clear) // Make the List background transparent
        .padding(.horizontal, 0)
    }
}



// Individual readings pages (Description, Intention, Layout)
struct ReadingDetailView: View {
    // provides access to the presentation mode environment value to dismiss the current view
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
