//
//  ContentView.swift
//  Swiftzee
//
//  Created by Antonio on 2023-04-03.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var controller = GameController()
    @State var viewController: UIViewController?
    @State var game = Game()
    @State var playerDiceNumber = 2
    @State var AIDiceNumber = 2
    @State var betNumber = 0
    @State var betMonies = 0
    @State var bank = 0

    var body: some View {
        ZStack {
            Color(red: 38/256, green: 108/256, blue: 59/256)
                .ignoresSafeArea()
            VStack {
                HStack {
                    /*Text("Bet on result: ")
                    Picker(selection: $betNumber, label: Text("Picker")) {
                        Text("1").tag(1)
                        Text("2").tag(2)
                        Text("3").tag(3)
                        Text("4").tag(4)
                        Text("5").tag(5)
                        Text("6").tag(6)

                    }
                    .onChange(of: betNumber) { newValue in
                        print("Betting on \(betNumber)")
                    }
                    .pickerStyle(.wheel)
                    TextField("Insert coin", value: $betMonies, formatter: NumberFormatter())
                        .onChange(of: betMonies) { newValue in
                        print("Betting this many monies: \(String(describing: betMonies))")
                        
                    }
                    .padding()
                    Text("$ \(bank)")

                        .padding()
                        .foregroundColor(.black)
                    Text(" monies")*/
                    Spacer(minLength: 20.00)
                    Text("Bank: \(controller.game.bank)")
                    Spacer(minLength: 20.00)
                    Text("Bet \(controller.game.betMonies!) monies on \(controller.game.betNumber)")
                    Spacer(minLength: 30.00)
                    TextField("Bet amount", value: $controller.game.betMonies, formatter: NumberFormatter())
                    Picker("Pick a number", selection: $controller.game.betNumber) {
                        ForEach(1..<7) {
                            Text("\($0 - 1)")
                        }
                    }
                    .onChange(of: controller.game.betNumber) { newValue in
                        print("Betting on \(controller.game.betNumber)")
                    }
                    .pickerStyle(.wheel)
                    Spacer(minLength: 40.00)
                }
                DiceView(n: playerDiceNumber)
                Button(action: {
                    newDiceValues()
                    //game.handleRollResult()
                    print("Current bank: \(controller.game.bank) - change: \(String(describing: controller.game.betMonies))")
                }, label: {
                    Text("Roll baby roll")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                })
                .background(Color(.red))
                .cornerRadius(CGFloat(20.0))
                .padding()
                Rectangle()
                    .frame(height: 2)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color.black)
                    .padding(.horizontal)
                DiceView(n: AIDiceNumber)

            }
            .padding()
            .onAppear {
                viewController = UIApplication.shared.windows.first?.rootViewController
            }
        }
        
    }
    
    struct DiceView : View {
        let n : Int
        var body : some View {
            Image(systemName: "die.face.\(n)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
        }
    }
    
    func newDiceValues() {
        playerDiceNumber = controller.rollDice()
        AIDiceNumber = controller.rollDice()
        
        let playerWinsAlert = UIAlertController(title: "Die cast!", message: "Player wins!", preferredStyle: .alert)
        let AIWinsAlert = UIAlertController(title: "Die cast!", message: "Computer wins!", preferredStyle: .alert)
        let drawAlert = UIAlertController(title: "Die cast!", message: "Draw!", preferredStyle: .alert)
        
        if controller.game.betNumber == playerDiceNumber {
            controller.game.bank += controller.game.betMonies!
        } else {
            if controller.game.bank >= controller.game.betMonies! {
                controller.game.bank -= controller.game.betMonies!
            } else if controller.game.bank < controller.game.betMonies! {
                controller.game.bank = 0
            }
        }

        if playerDiceNumber > AIDiceNumber {
            playerWinsAlert.addAction(UIAlertAction(title: "OK", style: .default))
            viewController?.present(playerWinsAlert, animated: true, completion: nil)
        } else if playerDiceNumber < AIDiceNumber {
            AIWinsAlert.addAction(UIAlertAction(title: "OK", style: .default))
            viewController?.present(AIWinsAlert, animated: true, completion: nil)
        } else {
            drawAlert.addAction(UIAlertAction(title: "OK", style: .default))
            viewController?.present(drawAlert, animated: true, completion: nil)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
