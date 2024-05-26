//
//  DailyView.swift
//  Trusted-Tarot
//
//  Created by Lindsay Clifford on 5/7/24.
//

import SwiftUI

struct DailyView: View {
    
    @State private var cardImage: String = "1 The Magician"
    @State private var isRandomizing: Bool = false
    @State private var isCardRevealed: Bool = false
    @State private var shufflePressed: Bool = false
    @State private var rotationAngle: Double = 0.0
    
    let cards: [String] = [
        "1 The Magician", "2 The High Priestess", "3 The Empress", "4 The Emperor",
        "5 The Hierophant", "6 The Lovers", "7 The Chariot", "8 Strength", "9 The Hermit", "10 Wheel of Fortune",
        "11 Justice", "12 The Hanged Man", "13 Death", "14 Temperance", "15 The Devil",
        "16 The Tower", "17 The Star", "18 The Moon", "19 The Sun", "20 Judgement", "21 The World",
        "22 Ace of Wands", "23 Two of Wands", "24 Three of Wands", "25 Four of Wands", "26 Five of Wands",
        "27 Six of Wands", "28 Seven of Wands", "29 Eight of Wands", "30 Nine of Wands", "31 Ten of Wands",
        "32 Page of Wands", "33 Knight of Wands", "34 Queen of Wands", "35 King of Wands",
        "36 Ace of Cups", "37 Two of Cups", "38 Three of Cups", "39 Four of Cups", "40 Five of Cups",
        "41 Six of Cups", "42 Seven of Cups", "43 Eight of Cups", "44 Nine of Cups", "45 Ten of Cups",
        "46 Page of Cups", "47 Knight of Cups", "48 Queen of Cups", "49 King of Cups",
        "50 Ace of Swords", "51 Two of Swords", "52 Three of Swords", "53 Four of Swords", "54 Five of Swords",
        "55 Six of Swords", "56 Seven of Swords", "57 Eight of Swords", "58 Nine of Swords", "59 Ten of Swords",
        "60 Page of Swords", "61 Knight of Swords", "62 Queen of Swords", "63 King of Swords",
        "64 Ace of Pentacles", "65 Two of Pentacles", "66 Three of Pentacles", "67 Four of Pentacles",
        "68 Five of Pentacles", "69 Six of Pentacles", "70 Seven of Pentacles", "71 Eight of Pentacles",
        "72 Nine of Pentacles", "73 Ten of Pentacles", "74 Page of Pentacles", "75 Knight of Pentacles",
        "76 Queen of Pentacles", "77 King of Pentacles", "O The Fool"
    ]
    
    // Date object
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }

    // Function to shuffle the array of cards
    func shuffleArray<T>(_ array: [T]) -> [T] {
        var newArray = array
        for i in stride(from: newArray.count - 1, through: 1, by: -1) {
            let j = Int.random(in: 0...i)
            newArray.swapAt(i, j)
        }
        return newArray
    }
    
    // Function to randomize the cards after each shuffle
    func randomizeCard() {
        if !isRandomizing {
            isRandomizing = true
            shufflePressed = true
            var shuffledCards = shuffleArray(cards)
            // Amount of time the cards are shuffled for
            let timer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
                shuffledCards = shuffleArray(shuffledCards)
                cardImage = shuffledCards[0]
            }
            let wiggleTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                withAnimation {
                    rotationAngle = (rotationAngle == 10.0) ? -10.0 : 10.0
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                timer.invalidate()
                wiggleTimer.invalidate()
                isRandomizing = false
                rotationAngle = 0.0
            }
        }
    }
    
    // Computed property for the shuffle button
    private var shuffleButton: some View {
        Button(action: {
            randomizeCard()
        }) {
            Text(isRandomizing ? "Shuffling..." : "Shuffle")
                .font(.headline)
                .foregroundColor(.white)
                .padding(10)
                .background(Color.blue)
                .cornerRadius(10)
        }
        .disabled(isRandomizing)
    }
    
    // Computed property for the draw card button
    private var drawCardButton: some View {
        Button(action: drawCardButtonTapped) {
            Text("Draw Card")
                .font(.headline)
                .foregroundColor(.white)
                .padding(10)
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.top, 500)
        }
    }
    
    
    // Main View (Daily View)
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Image("galaxy_2")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    
                    Image("wheel")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        .frame(width: geometry.size.width * 2, height: geometry.size.width * 2)
                        .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.01)
                        .opacity(0.1)
                    
                    Color.clear.overlay(
                        VStack(alignment: .center, spacing: 10) {
                            Text(dateFormatter.string(from: Date()))
                                .font(.system(size: 20))
                                .font(.largeTitle)
                                .fontWeight(.thin)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.top, 100)
                            
                            Text("Daily Reading")
                                .font(.custom("Respira-Black", size: 30))
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 0)
                            Spacer()
  
                            // Shuffle button var
                            shuffleButton
                                .padding(.bottom, 220)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    )
                    
                    // If card is revealed
                    if isCardRevealed {
                        Image(cardImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.4) // adjust the size of the card image
                            .padding(.bottom, 50)
                            .rotationEffect(.degrees(rotationAngle))
                    // If card is not revealed
                    } else {
                        Image("card_back")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.4) // adjust the size of the card image
                            .padding(.bottom, 50)
                            .rotationEffect(.degrees(rotationAngle))
                    }
                    // If card is currently shuffling
                    if isRandomizing {
                    }
                    // If card is not currently shuffling
                    if !isRandomizing {
                        // Draw Card BUTTON
                        Button(action: {
                            randomizeCard()
                            isCardRevealed = true
                        }) {
                            Text("Draw Card")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .padding(.top, 500)
                        }
                        
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    // Function to handle 'Draw Card' button tap
    private func drawCardButtonTapped() {
        // No action needed for now
    }
}


#Preview {
    ContentView()
}
