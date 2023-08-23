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
    @State var answer = "ORANGE"
    @State var score = 0
    @State var showSuccess = false
    
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
    
                    Text("score: \(score)")
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
                                        
                                        if guessedLetters.count == scrambledLetters.count {
                                            let guessedWord = guessedLetters.compactMap { $0.text }.joined()
                                            if guessedWord == answer {
                                                score += 1
                                                showSuccess = true
                                            }
                                            
//                                            let guessedWord = guessedLetters.compactMap { queryLetter in
//                                                return queryLetter.text
//                                            }
//                                            var guessedWord = ""
//                                            for letter in guessedLetters {
//                                                guessedWord += letter.text
//                                            }
                                            
                                        }
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
                //layer rep. success view
                if showSuccess {
                    VStack {
                        Image("tick")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.4))
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
