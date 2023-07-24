//
//  GameView.swift
//  SpeakingTraining
//
//  Created by man ching chan on 23/7/2023.
//

import SwiftUI

struct GameView: View {
    
    
    
    @EnvironmentObject var vm : SpeakingViewModel
    @ObservedObject var voiceOut = VoiceOut()
   @ObservedObject var speechRecognition = SpeechRecognizer()
    
    
    @State private var isStartCounterShow : Bool = true
    @State private var startTimerCounter : Int = 2
    
    
    @State private var isGameTimerCounter : Int = 10
    @State private var numOfQuestion : Int = 5
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    var gameTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    


    
    @State private var gameTimerCounter : Int = 5
    
    
    var body: some View {
        

        
        ZStack{
            Text("\(startTimerCounter)")
                .fontWeight(.bold)
                .font(.system(size: 200))
                .opacity(isStartCounterShow ? 1 : 0)
            
            
            VStack{
                
                
                Text("\(vm.randomNumber)")
                    .font(.system(size: 100))
                    .lineLimit(1)
                    .opacity(isStartCounterShow ? 0 : 1)
            }
            
            
        }
        .onAppear{
            
            print("on appear")
            print(vm.languageSelect)
            print(vm.levelSelect)
            
        }
        .onReceive(timer) { _ in
            startTimerCounter -= 1
            
            print("Start counter \(startTimerCounter)")
            
            if (startTimerCounter <= 0){
                
                self.timer.upstream.connect().cancel()
                isStartCounterShow = false
                startGame()
            }
        }
        .onReceive(gameTimer) { _ in
            
            gameTimerCounter -= 1
            print("Game counter \(gameTimerCounter)")
            
            if (gameTimerCounter <= 0){
                
                self.gameTimerCounter = 5
                startGame()
                
            }
        }
        
    }
    
    
    func startGame(){
        
        print("start game")
        vm.generateRandom()
       

    }
    
    
    
    
}






struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject({()-> SpeakingViewModel in
                let envObj = SpeakingViewModel()
                envObj.languageSelect = "th-TH"
                envObj.levelSelect = .Difficult
                return envObj
                
            }())
    }
}
