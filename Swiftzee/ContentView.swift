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
    //@State var game = Game()
    @State var playerDiceNumber = 2
    @State var AIDiceNumber = 2
    @State var betNumber = 0
    @State var betMonies = 0
    @State var bank = 0
    @State var selectedSize : Int
    let humanOpponent : Bool
    

    var body: some View {
        ZStack {
            Color(red: 38/256, green: 108/256, blue: 59/256)
                .ignoresSafeArea()
            VStack {
                Text("Selected size: \(selectedSize), human opponent?")
                HStack {
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
        }.onAppear {
            controller.game.dieSize = selectedSize
        }
        
    }
    
    struct DiceView : View {
        let n : Int
        var body : some View {
            Image(systemName: "\(n).square")
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
        ContentView(selectedSize: 6, humanOpponent: true)
    }
}
