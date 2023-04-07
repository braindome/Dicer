//
//  IntroPage.swift
//  Swiftzee
//
//  Created by Antonio on 2023-04-06.
//

import SwiftUI

struct IntroPage: View {
    
    let dieSize = [4, 6, 8, 10, 12, 20]
    @State var chosenSize = 6
    @State var isHuman = false
    @State var navigateToNextView = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer(minLength: 30)
                    Text("Die size:")
                    Picker("Select the number of faces", selection: $chosenSize) {
                        ForEach(dieSize, id: \.self) { size in
                            Text("\(size)")
                        }
                    }
                    .pickerStyle(.segmented)
                    Spacer(minLength: 30)
                    
                }
                HStack {
                    Text("Select opponent:")
                    Picker("Select opponent type", selection: $isHuman) {
                        Text("Computer").tag(false)
                        Text("Human").tag(true)
                    }
                }
                NavigationLink(destination: ContentView(selectedSize: chosenSize, humanOpponent: isHuman), isActive: $navigateToNextView) {
                    EmptyView()
                }
                Button("Next") {
                    navigateToNextView = true
                    
                }
                .padding()
                .ignoresSafeArea(.keyboard)
            }
        }
    }
}

struct IntroPage_Previews: PreviewProvider {
    static var previews: some View {
        IntroPage()
    }
}
