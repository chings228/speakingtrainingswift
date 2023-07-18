//
//  ContentView.swift
//  SpeakingTraining
//
//  Created by man ching chan on 10/7/2023.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    
   @State private var RandomNumber = 0

     @ObservedObject var voiceOut = VoiceOut()
    @ObservedObject var speechRecognition = SpeechRecoginition()
    
    @State var selectLang = "en-US"
    
    
    let langs  = [
        "en-US": "English",
        "zh-HK":"Chinese",
        "th-TH":"Thai"
    ]
    
    
    var body: some View {
        VStack(spacing:20) {
            

                
                Picker("Select Lang",selection:$selectLang){
                    
                    ForEach(Array(langs.keys), id: \.self) { key in
                          
                              Text(langs[key] ?? "")
                          
                      }

                    
                }
  
            
            Button("Generate Random") {
                print("click")
                
                if let lang = langs["en-US"]{
                    print("\(lang)")
                }
               
                
                RandomNumber = Int.random(in: 1..<1000)
                
                //voiceOut.readnumber(speech: String(RandomNumber),lang: selectLang)
                
                speechRecognition.listenToSpeech()
                
                
            }
            .disabled(voiceOut.isTalk ? true:false)
            
            
            Text(voiceOut.isTalk ? "wwodwowo" : "tututututu")

            
            Text("\(RandomNumber)")
                .font(.title)
            
            
            Button("Stop") {
                voiceOut.isTalk = false
                voiceOut.stop()
            }
            .disabled(voiceOut.isTalk ? false : true)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
