//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Carlos Eduardo Witte on 08/07/24.
//

import SwiftUI

struct ShapeButton: View {
    var shape: String
    
    var body: some View {
        Image(systemName: shape)
            .shadow(radius: 5)
            .font(.system(size: 80))
            .foregroundColor(.primary)
            .background(.secondary)
            .clipShape(.circle)
            .padding()
    }
}

struct ContentView: View {
    @State var shapes = ["mountain.2.fill", "doc.fill", "scissors"].shuffled()
    @State var userChoice = ""
    @State var score = 0
    @State var shouldWin = Bool.random()
    @State var userWins = false
    
    let rock = "mountain.2.fill"
    let paper = "doc.fill"
    let scissors = "scissors"
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Text(Image(systemName: shapes[0]))
                    .font(.system(size: 100))
                
                Text("\(shouldWin ? "Win" : "Loose")")
                    .font(.system(size: 60))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)

                    Button {
                        play(with: rock)
                    } label: {
                        ShapeButton(shape: rock)
                    }
                    
                    Button {
                        play(with: paper)
                    } label: {
                        ShapeButton(shape: paper)
                    }
                    
                    Button {
                        play(with: scissors)
                    } label: {
                        ShapeButton(shape: scissors)
                    }
                    

                Text("^[\(score) point](inflect: true)")
                    .font(.largeTitle.weight(.bold))
            }
            .padding()
        }
        .navigationTitle("Rock, Paper, Scissors")
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
    }
    
    func play(with userSelection: String) {
        if shouldWin && shapes[0] == rock {
            if userSelection == scissors {
                // rocks beats scissors
                score -= 1
                userWins = false
            } else if userSelection == paper {
                // paper beats rock
                score += 1
                userWins = true
            }
        } else if shouldWin && shapes[0] == paper {
            if userSelection == rock {
                // paper beats rock
                score -= 1
                userWins = false
            } else if userSelection == scissors {
                // scissor beats paper
                score += 1
                userWins = true
            }
        } else if shouldWin && shapes[0] == scissors {
            if userSelection == rock {
                // rocks beats scissors
                score += 1
                userWins = true
            } else if userSelection == paper {
                score -= 1
                userWins = false
            }
        } else if !shouldWin && shapes[0] == rock {
            if userSelection == paper {
                // paper beats rock, but user is supposed to loose
                score -= 1
                userWins = false
            } else if userSelection == scissors {
                // rock beats scissors, and user is supposed to loose
                score += 1
                userWins = true
            }
        } else if !shouldWin && shapes[0] == paper {
            if userSelection == scissors {
                // scissors beat paper, but user is supposed to loose
                score -= 1
                userWins = false
            } else if userSelection == rock {
                // paper beats rock, but user is supposed to loose
                score += 1
                userWins = true
            }
        }

        print()
        print()
        print("App told you to \(shouldWin ? "win" : "loose"), and you \(userWins ? "win" : "loose").")
        print("app shows \(shapes[0]) and you selected \(userSelection)")
        print(score)
        shouldWin = Bool.random()
        shapes.shuffle()
    }
}

#Preview {
    ContentView()
}
