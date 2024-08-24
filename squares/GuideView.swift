//
//  GuideView.swift
//  squares
//
//  Created by Dinitha Gamage on 2024-08-22.
//

import Foundation
import SwiftUI

struct GuideView: View {
    let onClose: () -> Void
    
    let guidelines: String = "1. Start the Game:\n- Press the \"Start\" button to begin the game.\n\n2. Grid Display:\n- A grid filled with colored squares will appear on the screen.\n\n3. Gameplay:\n- Your goal is to match pairs of squares with the same color.\n- Click on any two squares. If they are the same color, you earn one point.\n- If you select squares with different colors, the game will end.\n\n4. Game Over:\n- When you select mismatched colors, the game will be over.\n- Your score will be displayed on the screen.\n\n5. Post-Game Options:\n- After the game ends, you will have two options:\n- Restart Game: Begin a new game and try to improve your score.\n- Go to Home: Return to the main menu.\n"
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Text("Here are the guidelines for the Square Matching Game:")
                        .font(.title2)
                        .padding(.top, 16)
                    Text(guidelines)
                        .padding(.top, 16)
                        .multilineTextAlignment(.leading)
                }
                .padding(.horizontal, 16)
            }
            VStack {
                
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [
                    Color(red: 1.0, green: 1.0, blue: 1.0).opacity(1.0),
                    Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.0)
                ]), startPoint: .top, endPoint: .bottom)
            )
            .frame(width: UIScreen.main.bounds.width, height: 20)
            
            Button(action: {
                onClose()
            }) {
                Image("home")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
        }
    }
}
