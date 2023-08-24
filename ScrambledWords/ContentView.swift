//
//  ContentView.swift
//  ScrambledWords
//
//  Created by shafique dassu on 15/08/2023.
//

import SwiftUI

struct Question {
    let image: String
    var scrambledLetters: [Letter]
    let answer: String
}

extension Question {
    static func generateQuestions() -> [Question] {
        return [
            Question(image: "orange", scrambledLetters: [
                Letter(id: 0, text: "R"),
                Letter(id: 1, text: "A"),
                Letter(id: 2, text: "N"),
                Letter(id: 3, text: "O"),
                Letter(id: 4, text: "G"),
                Letter(id: 5, text: "E")
            ], answer: "ORANGE"),
            Question(image: "strawberry", scrambledLetters: [
                Letter(id: 0, text: "T"),
                Letter(id: 1, text: "S"),
                Letter(id: 2, text: "B"),
                Letter(id: 3, text: "A"),
                Letter(id: 4, text: "W"),
                Letter(id: 5, text: "R"),
                Letter(id: 6, text: "R"),
                Letter(id: 7, text: "E"),
                Letter(id: 8, text: "R"),
                Letter(id: 9, text: "Y")
            ], answer: "STRAWBERRY"),
            Question(image: "apple", scrambledLetters: [
                Letter(id: 0, text: "P"),
                Letter(id: 1, text: "P"),
                Letter(id: 2, text: "L"),
                Letter(id: 3, text: "E"),
                Letter(id: 4, text: "A")
            ], answer: "APPLE")
        ]
    }
}


struct ContentView: View {
    
    @State var guessedLetters: [Letter] = []
    
    @State var questions: [Question] = [
        Question(image: "orange", scrambledLetters: [
            Letter(id: 0, text: "R"),
            Letter(id: 1, text: "A"),
            Letter(id: 2, text: "N"),
            Letter(id: 3, text: "O"),
            Letter(id: 4, text: "G"),
            Letter(id: 5, text: "E")
        ], answer: "ORANGE"),
        Question(image: "strawberry", scrambledLetters: [
            Letter(id: 0, text: "T"),
            Letter(id: 1, text: "S"),
            Letter(id: 2, text: "B"),
            Letter(id: 3, text: "A"),
            Letter(id: 4, text: "W"),
            Letter(id: 5, text: "R"),
            Letter(id: 6, text: "R"),
            Letter(id: 7, text: "E"),
            Letter(id: 8, text: "R"),
            Letter(id: 9, text: "Y")
        ], answer: "STRAWBERRY"),
        Question(image: "apple", scrambledLetters: [
            Letter(id: 0, text: "P"),
            Letter(id: 1, text: "P"),
            Letter(id: 2, text: "L"),
            Letter(id: 3, text: "E"),
            Letter(id: 4, text: "A")
        ], answer: "APPLE")
    ]
    
    @State var currentQuestionIndex = 0
    @State var score = 0
    @State var showSuccess = false
    @State var showFail = false
    @State var showScoreView = false
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color("background").ignoresSafeArea()
                
                VStack {
                    VStack {
                        Spacer()
                        Image(questions[currentQuestionIndex].image)
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
                                        questions[currentQuestionIndex].scrambledLetters[letter.id] = newLetter
                                    }
                                    Rectangle()
                                        .fill(Color.white)
                                        .frame(width: 25, height: 2)
                                }
                            }
                        }
                        .frame(height: 40)
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
                        ForEach(questions[currentQuestionIndex].scrambledLetters) { letter in
                            LetterView(character: letter.text)
                                .onTapGesture {
                                    
                                    if !letter.text.isEmpty {
                                        guessedLetters.append(letter)
                                        let newLetter = Letter(id: letter.id, text: "")
                                        questions[currentQuestionIndex].scrambledLetters[letter.id] = newLetter
                                        questions[currentQuestionIndex].scrambledLetters[letter.id] = newLetter
                                        
                                        if guessedLetters.count == questions[currentQuestionIndex].scrambledLetters.count {
                                            let guessedWord = guessedLetters.compactMap { $0.text }.joined()
                                            if guessedWord == questions[currentQuestionIndex].answer {
                                                score += 1
                                                withAnimation {
                                                    showSuccess = true
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                                        showSuccess = false
//                                                        for guessedLetter in guessedLetters {
//                                                            questions[currentQuestionIndex].scrambledLetters[guessedLetter.id] = guessedLetter
//                                                        }
                                                        guessedLetters.removeAll()
                                                        if currentQuestionIndex == questions.count - 1 {
                                                            showScoreView = true
                                                        } else {
                                                            currentQuestionIndex += 1
                                                        }
                                                        
                                                    })
                                                }
                                            } else {
                                                withAnimation {
                                                    showFail = true
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                                        showFail = false
//                                                        for guessedLetter in guessedLetters {
//                                                            questions[currentQuestionIndex].scrambledLetters[guessedLetter.id] = guessedLetter
//                                                        }
                                                        guessedLetters.removeAll()
                                                        
                                                        if currentQuestionIndex == questions.count - 1 {
                                                            showScoreView = true
                                                        } else {
                                                            currentQuestionIndex += 1
                                                        }                                                    })
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                                            
//                                            let guessedWord = guessedLetters.compactMap { queryLetter in
//                                                return queryLetter.text
//                                            }
//                                            var guessedWord = ""
//                                            for letter in guessedLetters {
//                                                guessedWord += letter.text
//                                            }
                                     
                                // let guessedLetter = Letter(text: letter.text, id: letter.id)
//                                    if !scrambledLetters[letter.id].text.isEmpty {
//                                        guessedLetters.append(letter)
//                                        let newLetter = Letter(id: letter.id, text: "")
//                                        scrambledLetters[letter.id] = newLetter
//                                    }
                         
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
                if showFail {
                    VStack {
                        Image("cross")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.4))
                }
            }
            .sheet(isPresented: $showScoreView, onDismiss: {
                questions = Question.generateQuestions()
                score = 0
                currentQuestionIndex = 0
            }, content: { ScoreView(score: score, questionCount: questions.count)
                    .presentationDetents([.fraction(0.4)])
            })
            
            .sheet(isPresented: $showScoreView) {
                ScoreView(score: score, questionCount: questions.count)
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
