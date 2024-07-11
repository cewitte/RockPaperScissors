//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Carlos Eduardo Witte on 08/07/24.
//

import SwiftUI

let rock = "mountain.2.fill"
let paper = "doc.fill"
let scissors = "scissors"
var playCount = 0

struct ShapeButton: View {
    var shape: String
    var color: Color
    
    var body: some View {
        Image(systemName: shape)
            .shadow(radius: 5)
            .font(.system(size: 60))
            .foregroundColor(color)
            .background(.background)
            .padding()
    }
}

struct ContentView: View {
    @State var shapes = ["mountain.2.fill", "doc.fill", "scissors"].shuffled()
    @State var userChoice = ""
    @State var score = 0
    @State var shouldWin = Bool.random()
    @State var userWins = false
    @State var showingAlert = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Label("\(shouldWin ? "Play to WIN" : "Play to LOSE")", systemImage: shapes[0])
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(shouldWin ? .blue : .red)

                Spacer()
                VStack(spacing: 30){
                    Button {
                        play(with: rock)
                    } label: {
                        ShapeButton(shape: rock, color: .black)
                    }
                    
                    Button {
                        play(with: paper)
                    } label: {
                        ShapeButton(shape: paper, color: .white)
                    }
                    
                    Button {
                        play(with: scissors)
                    } label: {
                        ShapeButton(shape: scissors, color: .gray)
                    }
                }
                
                Spacer()
                    
                Text("^[\(score) point](inflect: true)")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(score < 0 ? .red : .blue)
            }
            .padding()
        }
        .alert("Game over!", isPresented: $showingAlert) {
            Button("OK") {
                reset()
            }
        } message: {
            Text("Your final score is ^[\(score) point](inflect: true) after ^[\(playCount) attempt](inflect: true).")
        }
    }
    
    func play(with userSelection: String) {
        playCount += 1
        
        if shouldWin && shapes[0] == rock {
            if userSelection == scissors {
                score -= 1
                userWins = false
            } else if userSelection == paper {
                score += 1
                userWins = true
            }
        } else if shouldWin && shapes[0] == paper {
            if userSelection == rock {
                score -= 1
                userWins = false
            } else if userSelection == scissors {
                score += 1
                userWins = true
            }
        } else if shouldWin && shapes[0] == scissors {
            if userSelection == rock {
                score += 1
                userWins = true
            } else if userSelection == paper {
                score -= 1
                userWins = false
            }
        } else if !shouldWin && shapes[0] == rock {
            if userSelection == paper {
                score -= 1
                userWins = false
            } else if userSelection == scissors {
                score += 1
                userWins = true
            }
        } else if !shouldWin && shapes[0] == paper {
            if userSelection == scissors {
                score -= 1
                userWins = false
            } else if userSelection == rock {
                score += 1
                userWins = true
            }
        } else if !shouldWin && shapes[0] == scissors {
            if userSelection == rock {
                score -= 1
                userWins = false
            } else if userSelection == paper {
                score += 1
                userWins = true
            }
        }
        
        if playCount == 10 {
            showingAlert = true
        }
        
        shouldWin = !shouldWin
        shapes.shuffle()
    }
    
    func reset() {
        playCount = 0
        score = 0
        showingAlert = false
        shouldWin = !shouldWin
        shapes.shuffle()
    }
}

#Preview {
    ContentView()
}
