//
//  HighScoreView.swift
//  squares
//
//  Created by Dinitha Gamage on 2024-08-22.
//

import Foundation
import SwiftUI

struct HighScoreView: View {
    let highScore: Int
    let onClose: () -> Void
    
    var body: some View {
        VStack {
            Text("High Score")
                .font(.largeTitle)
                .padding()
            Text("\(highScore)")
                .font(.system(size: 100))
                .bold()
                .padding()
            Spacer()
            Button(action: {
                onClose()
            }) {
                Image("home")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            .padding()
        }
    }
}
