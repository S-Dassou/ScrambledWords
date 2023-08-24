//
//  ScoreView.swift
//  ScrambledWords
//
//  Created by shafique dassu on 24/08/2023.
//

import SwiftUI

struct ScoreView: View {
    let score: Int
    let questionCount: Int
    
    var body: some View {
        ZStack {
            Color("background")
                .opacity(0.7)
                .ignoresSafeArea()
            VStack {
                Text("Final Score")
                    .foregroundColor(.white)
                    .font(.system(size: 26, weight: .semibold))
                    .padding(.bottom, 8)
                Text("Score \(score) / \(questionCount)")
                    .foregroundColor(Color.white)
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top, 30)
        }
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(score: 3, questionCount: 4)
    }
}
