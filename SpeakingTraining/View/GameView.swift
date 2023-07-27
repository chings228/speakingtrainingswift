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
    @State private var startTimerCounter : Int = Utils.startCounterVal
    
    
    @State private var gameTimerCounter : Int = Utils.gameTimerCounterVal
    
    let   maxNumOfQuestion : Int = Utils.numOfQuestionVal
    
    
    @State var timer = Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    @State var gameTimer = Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    @State var idleTimer = Timer.publish(every: 2, on: .main, in: .common)
        .autoconnect()
    
    @State private var idleTimerCounter: Int = -1
    
    @State var isTalkingAnswer : Bool = false;
    
    @ObservedObject var voiceOut = VoiceOut()
   @StateObject var speechRecognition = SpeechRecognizer()
    
    @State var totalMark = 0
    
    @State var numOfQuestion = 0
    
    @State var isShowFinish : Bool = false
    

    
    var body: some View {
        

        ZStack{

            
            VStack{
                Text("\(startTimerCounter)")
                    .fontWeight(.bold)
                    .font(.system(size: 250))
                    
                    .opacity(isStartCounterShow ? 1 : 0)
                
                
                
            }
            
            
            VStack{
                
                Text("Finish")
                    .fontWeight(.bold)
                    .font(.system(size: 180))
                    .lineLimit(1)
                    .padding([.leading,.trailing],30)
                    .minimumScaleFactor(0.3)
                
                
                Text("Mark : \(totalMark)")
                    .fontWeight(.bold)
                    .font(.system(size:70))
                    .lineLimit(1)
                    .minimumScaleFactor(0.3)
                
                Text(vm.finishMessage)
                    .fontWeight(.bold)
                    .font(.system(size:50))
                    .lineLimit(2)
                    .minimumScaleFactor(0.3)
                    .foregroundColor(.blue)
                    .frame(maxWidth:.infinity,alignment: .center)
            }

            .opacity(isShowFinish ?  1 : 0)
            
            
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
               
                    
                
                ProgressView(value:CGFloat(max(0,gameTimerCounter)),total:CGFloat(Utils.gameTimerCounterVal))
                    .padding([.leading, .trailing],10)
                    .tint(Color.red)
                    .scaleEffect(x:1 ,y:2 ,anchor:.center)
                    .frame(height: 8.0)
                   

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
            .opacity(isStartCounterShow || isShowFinish ? 0 : 1)
           
            
            
        }
        .onDisappear{
            self.gameTimer.upstream.connect().cancel()
            self.timer.upstream.connect().cancel()
            self.gameTimerCounter = Utils.gameTimerCounterVal
            self.startTimerCounter = Utils.startCounterVal
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
            //print("Game counter \(gameTimerCounter)")
                
                if (gameTimerCounter == 0){
                    
                    
                    // read first
                    
                    print("read ")
                    isTalkingAnswer = true
                    
                    
                    self.speechRecognition.resetTranscript()
                    self.speechRecognition.stopTranscribing()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {

                        voiceOut.readnumber(lang: vm.languageSelect, speech: String(vm.randomNumber))
                    }
                    
                    
                    
                    
                   
                    //startGame()
                    //self.gameTimer.upstream.connect().cancel()
                    
                }
            }
            

        }
        .onReceive(idleTimer){_ in
            
            if (!isStartCounterShow){
                
                idleTimerCounter -= 1
                
                if (idleTimerCounter == 0){
                    

                    print("reset transcript")
                    speechRecognition.transcript = ""
                    
                    self.speechRecognition.resetTranscript()
                    self.speechRecognition.startTranscribing()
                    
                }
                
                
            }
            
        }
        
        .onChange(of : voiceOut.isFinishTalk){ isFinishTalk in
            
            if (isTalkingAnswer && isFinishTalk){
                
                print("finish talk")
                isTalkingAnswer = false
                voiceOut.isFinishTalk = false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    startGame()
                }
                
            }
            
            
            
            
        }
        
        
        .onChange(of: speechRecognition.transcript) { newValue in
            print("new speech \(newValue)")
            
            
            
            
            print(Utils.convertToNumberReading(num: Int(newValue) ?? 0, locale: vm.languageSelect))
            
            if (Int(newValue) == vm.randomNumber){
                
                print("bingo")
               
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    startGame()
                }
               
            }
            else{
                print("no bingo")
                
                self.idleTimerCounter = Utils.idleTimerCounterVal
                
                
                
            }
        }

        
    }
    
    
    func startGame(){
        
        
            numOfQuestion += 1
            
            if (numOfQuestion <= maxNumOfQuestion){
            
            
            print("start game")
            vm.generateRandom()
            
            
            self.gameTimerCounter = Utils.gameTimerCounterVal
            
            self.idleTimerCounter =  -1
            
            

            speechRecognition.resetTranscript()

            speechRecognition.startTranscribing()
        
        }
        else{
            print("game end")
            print(maxNumOfQuestion,numOfQuestion)
            self.speechRecognition.stopTranscribing()
            isShowFinish = true
        }
    }
    
    
    
    
}






struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject({()-> SpeakingViewModel in
                let envObj = SpeakingViewModel()
                envObj.languageSelect = "zh-HK"
                envObj.levelSelect = .Medium
                return envObj
                
            }())
    }
}
