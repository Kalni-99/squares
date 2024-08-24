//
//  GameState.swift
//  squares
//
//  Created by Dinitha Gamage on 2024-08-22.
//

import Foundation

class GameState: ObservableObject {
    @Published var buttons: [ButtonState] = Array(repeating: ButtonState(color: .peach), count: 9)
    @Published var selectedButtons: [Int] = []
    @Published var score: Int = 0
    @Published var gameOver: Bool = false
    @Published var showHighScore: Bool = false
    @Published var showGuide: Bool = false
    @Published var gameStarted: Bool = false
    @Published var highScore: Int = 0
    
    init() {
        resetButtons()
    }
    
    func resetButtons() {
        buttons = buttons.map { _ in ButtonState(color: ColorOption.allCases.randomElement()!) }
    }
    
    func buttonTapped(index: Int) {
        guard !gameOver else { return }
        guard !selectedButtons.contains(index) else { return }
        
        selectedButtons.append(index)
        
        if selectedButtons.count == 2 {
            let firstIndex = selectedButtons[0]
            let secondIndex = selectedButtons[1]
            
            if buttons[firstIndex].color == buttons[secondIndex].color {
                score += 1
                highScore = max(highScore, score)
                // Change colors after clicking both
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.buttons[firstIndex].color = ColorOption.allCases.randomElement()!
                    self.buttons[secondIndex].color = ColorOption.allCases.randomElement()!
                }
            } else {
                // Game over if not matching
                gameOver = true
            }
            
            // Clear selection
            selectedButtons.removeAll()
        }
    }
    
    func restartGame() {
        gameStarted = true
        gameOver = false
        score = 0
        resetButtons()
    }
    
    func startNewGame() {
        gameStarted = true
        gameOver = false
        score = 0
        resetButtons()
    }
    
    func backToMenu() {
        gameStarted = false
        gameOver = false
        selectedButtons.removeAll()
        score = 0
        resetButtons()
    }
}
