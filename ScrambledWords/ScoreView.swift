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
    @Binding var showScoreView: Bool
//    @Environment (\.presentationMode) var presentationMode
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color("background")
                .opacity(0.7)
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    
                    Button(action: {
//                        showScoreView = false
                        dismiss()
                    }, label: { Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .bold))
                    })
                
                }
                .padding()
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
        ScoreView(score: 3, questionCount: 4, showScoreView: .constant(true))
    }
}
