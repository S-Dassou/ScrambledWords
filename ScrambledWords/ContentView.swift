//
//  ContentView.swift
//  ScrambledWords
//
//  Created by shafique dassu on 15/08/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var guessedLetters: [Letter] = []
    @State var scrambledLetters: [Letter] = [
        Letter(text: "R", id: 0),
        Letter(text: "A", id: 1),
        Letter(text: "N", id: 2),
        Letter(text: "O", id: 3),
        Letter(text: "G", id: 4),
        Letter(text: "E", id: 5)
    ]
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color("background").ignoresSafeArea()
                
                VStack {
                    VStack {
                        Spacer()
                        Image("Orange")
                            .resizable()
                            .frame(width: 100, height: 100)
                        Spacer()
                        HStack {
                            VStack {
                                LetterView(character: "A")
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: 25, height: 2)
                            }
                        }
                        .padding(.bottom, 20)
                    }
                    .frame(width: proxy.size.width * 0.9, height: proxy.size.width * 0.9)
                    .overlay(RoundedRectangle(cornerRadius: 8) .stroke(Color("divider"), lineWidth: 2))
                    .padding(.top, 20)
    
                    Text("score: 0")
                        .font(.system(size: 15))
                        .foregroundColor(Color.white)
                        .padding(.top, 10)
                    HStack {
                        ForEach(scrambledLetters) { letter in
                            LetterView(character: letter.text)
                        }
                    }
                    Spacer()
                }
            }
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct LetterView: View {
    let character: String
    var body: some View {
        Text(character)
            .font(.system(size: 15, weight: .semibold))
            .foregroundColor(Color.white)
            .frame(width: 30, height: 30)
            .background(Color.white.opacity(0.4))
            .cornerRadius(4)
    }
}
