//
//  ContentView.swift
//  squares
//
//  Created by Dinitha Gamage on 2024-08-22.
//

import SwiftUI

enum ColorOption: CaseIterable {
    case peach, yellowGreen, lightBlue, stoneGray
}

struct ContentView: View {
    @StateObject private var gameState = GameState()
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack {
            if !gameState.gameStarted {
                Image("appIcon")
                    .resizable()
                    .frame(width: 160, height: 160)
                    .padding()
            }
            
            if gameState.gameStarted {
                VStack {
                    if !gameState.gameOver {
                        Text("Score: \(gameState.score)")
                            .font(.largeTitle)
                            .padding()
                    }
                    
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(gameState.buttons.indices, id: \.self) { index in
                            Button(action: {
                                gameState.buttonTapped(index: index)
                            }) {
                                Rectangle()
                                    .fill(colorForOption(gameState.buttons[index].color))
                                    .frame(width: 100, height: 100)
                                    .border(Color.black, width: 1)
                                    .cornerRadius(5)
                                    .opacity(gameState.selectedButtons.contains(index) ? 0.5 : 1.0)
                            }
                            .disabled(gameState.gameOver)
                        }
                    }
                    .padding()
                    
                    if gameState.gameOver {
                        Text("Game Over!")
                            .font(.title)
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                        Text("Score: \(gameState.score)")
                            .font(.title)
                        HStack {
                            Button(action: {
                                gameState.restartGame()
                            }) {
                                Image("rotate_right")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                gameState.backToMenu()
                            }) {
                                Image("home")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                        }
                        .padding(.horizontal, 80)
                        .padding(.top, 40)
                    }
                }
            } else {
                VStack(spacing: 20) {
                    Button(action: {
                        gameState.startNewGame()
                    }) {
                        HStack(spacing: 16) {
                            Spacer()
                            Text("BEGIN")
                                .font(.title)
                                .fontWeight(.heavy)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color(red: 0.92, green: 0.43, blue: 0.48))
                            Spacer()
                        }
                        .frame(height: 60)
                        .background(Color(red: 0.55, green: 0.77, blue: 0.86))
                        .cornerRadius(6.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6.0)
                                .stroke(Color(red: 0.25, green: 0.22, blue: 0.16), lineWidth: 1.7)
                        )
                    }
                    
                    Button(action: {
                        gameState.showHighScore.toggle()
                    }) {
                        HStack(spacing: 16) {
                            Spacer()
                            Text("HIGH SCORE")
                                .font(.title)
                                .fontWeight(.heavy)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color(red: 0.92, green: 0.43, blue: 0.48))
                            Spacer()
                        }
                        .frame(height: 60)
                        .background(Color(red: 0.55, green: 0.77, blue: 0.86))
                        .cornerRadius(6.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6.0)
                                .stroke(Color(red: 0.25, green: 0.22, blue: 0.16), lineWidth: 1.7)
                        )
                    }
                    .sheet(isPresented: $gameState.showHighScore) {
                        HighScoreView(highScore: gameState.highScore) {
                            gameState.showHighScore = false
                        }
                    }
                    
                    Button(action: {
                        gameState.showGuide.toggle()
                    }) {
                        HStack(spacing: 16) {
                            Spacer()
                            Text("HOW TO PLAY")
                                .font(.title)
                                .fontWeight(.heavy)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color(red: 0.92, green: 0.43, blue: 0.48))
                            Spacer()
                        }
                        .frame(height: 60)
                        .background(Color(red: 0.55, green: 0.77, blue: 0.86))
                        .cornerRadius(6.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6.0)
                                .stroke(Color(red: 0.25, green: 0.22, blue: 0.16), lineWidth: 1.7)
                        )
                    }
                    .sheet(isPresented: $gameState.showGuide) {
                        GuideView {
                            gameState.showGuide = false
                        }
                    }
                }
                .frame(width: 300)
                .padding()
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(
            LinearGradient(gradient: Gradient(colors: [
                Color(red: 0.45, green: 0.67, blue: 0.76),
                Color(red: 0.53, green: 0.48, blue: 0.44)
            ]), startPoint: .top, endPoint: .bottom)
        )
    }
    
    private func colorForOption(_ option: ColorOption) -> Color {
        switch option {
        case .peach:
            return Color(red: 0.92, green: 0.43, blue: 0.48)
        case .yellowGreen:
            return Color(red: 0.83, green: 0.86, blue: 0.34)
        case .lightBlue:
            return Color(red: 0.55, green: 0.77, blue: 0.86)
        case .stoneGray:
            return Color(red: 0.53, green: 0.48, blue: 0.44)
        }
    }
}

#Preview {
    ContentView()
}
