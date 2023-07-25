//
//  GameView.swift
//  SpeakingTraining
//
//  Created by man ching chan on 23/7/2023.
//

import SwiftUI

struct GameView: View {
    
    
    
    @EnvironmentObject var vm : SpeakingViewModel

    
    
    @State private var isStartCounterShow : Bool = true
    @State private var startTimerCounter : Int = 2
    
    
    @State private var gameTimerCounter : Int = 10
    @State private var numOfQuestion : Int = 5
    
    
    @State var timer = Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    @State var gameTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @ObservedObject var voiceOut = VoiceOut()
   @StateObject var speechRecognition = SpeechRecognizer()

    
    
    var body: some View {
        

        
        ZStack{
            Text("\(startTimerCounter)")
                .fontWeight(.bold)
                .font(.system(size: 200))
                .opacity(isStartCounterShow ? 1 : 0)
            
            
            VStack{
                
                ZStack{
                    
                    
                    Rectangle()
                        .frame(height: 100)
                        .foregroundColor(.clear)
                    
                    Text("\(vm.randomNumber,format: .number.grouping(.never))")
                        .font(.system(size: 100))
                        .lineLimit(1)
                        .frame(height:100)
                        .minimumScaleFactor(0.3)
                        
                    
                }
                .opacity(isStartCounterShow ? 0 : 1)
                    
                    
                ZStack{
                    
                    Rectangle()
                        .frame(height: 100)
                        .foregroundColor(.clear)
                    
                    
                    
                    Text(speechRecognition.transcript)
                        .font(.system(size:100))
                        .lineLimit(1)
                        .frame(height:100)
                        .minimumScaleFactor(0.3)
                                            
                }
                

                    
            }
            
            
        }
        .onDisappear{
            self.gameTimer.upstream.connect().cancel()
            self.timer.upstream.connect().cancel()
            self.gameTimerCounter = 10
            self.startTimerCounter = 2
            self.speechRecognition.stopTranscribing()
        }
        .onAppear{
            
            print("on appear")
            print(vm.languageSelect)
            print(vm.levelSelect)
            
    
            
        }
        .onReceive(timer) { _ in
            startTimerCounter -= 1
            
            print("Start counter \(startTimerCounter)")
            
            if (startTimerCounter == 0){
                
                self.timer.upstream.connect().cancel()
                isStartCounterShow = false
                startGame()
            }
        }
        .onReceive(gameTimer) { _ in
            
            if (!isStartCounterShow){
                
                gameTimerCounter -= 1
                print("Game counter \(gameTimerCounter)")
                
                if (gameTimerCounter == 0){
                    
                   
                    startGame()
                    
                }
            }
            

        }
        .onChange(of: speechRecognition.transcript) { newValue in
            print("new speech \(newValue)")
            
            if (Int(newValue) == vm.randomNumber){
                
                print("bingo")
                
                startGame()
            }
        }
        
    }
    
    
    func startGame(){
        
        print("start game")
        vm.generateRandom()
        
        self.gameTimerCounter = 10
            
        speechRecognition.resetTranscript()

        speechRecognition.startTranscribing()
       
        //voiceOut.readnumber(lang:vm.languageSelect, speech: String(vm.randomNumber))
    }
    
    
    
    
}






struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject({()-> SpeakingViewModel in
                let envObj = SpeakingViewModel()
                envObj.languageSelect = "zh-HK"
                envObj.levelSelect = .Difficult
                return envObj
                
            }())
    }
}
