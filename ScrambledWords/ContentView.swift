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
        Letter(id: 0, text: "R"),
        Letter(id: 1, text: "A"),
        Letter(id: 2, text: "N"),
        Letter(id: 3, text: "O"),
        Letter(id: 4, text: "G"),
        Letter(id: 5, text: "E")
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
                            ForEach(guessedLetters) { letter in
                            VStack {
                                    LetterView(character: letter.text)
                                    .onTapGesture {
                                        if let index = guessedLetters.firstIndex(where: { queryLetter in
                                            queryLetter.id == letter.id
                                        }) {
                                            guessedLetters.remove(at: index)
                                        }
                                        let newLetter = Letter(id: letter.id, text: letter.text)
                                        scrambledLetters[letter.id] = newLetter
                                    }
                                
                                    Rectangle()
                                        .fill(Color.white)
                                        .frame(width: 25, height: 2)
                                }
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
                                .onTapGesture {
                                    if !letter.text.isEmpty {
                                        guessedLetters.append(letter)
                                        let newLetter = Letter(id: letter.id, text: "")
                                        scrambledLetters[letter.id] = newLetter
                                    }
                                // let guessedLetter = Letter(text: letter.text, id: letter.id)
//                                    if !scrambledLetters[letter.id].text.isEmpty {
//                                        guessedLetters.append(letter)
//                                        let newLetter = Letter(id: letter.id, text: "")
//                                        scrambledLetters[letter.id] = newLetter
//                                    }
                                }
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
