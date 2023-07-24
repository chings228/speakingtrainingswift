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
    
    
    var body: some View {
        
        VStack{
            
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
            .onAppear{
                
                    print("on appear")
                print(vm.languageSelect)
                print(vm.level)
            }
    }

}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject({()-> SpeakingViewModel in
                let envObj = SpeakingViewModel()
                envObj.languageSelect = "th-TH"
                envObj.level = 2
                return envObj
                
            }())
    }
}
