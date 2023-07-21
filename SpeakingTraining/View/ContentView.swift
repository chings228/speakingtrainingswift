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
    @ObservedObject var speechRecognition = SpeechRecognizer()
    
    @AppStorage("selectLang") private var selectLang = "en-US"
    

    
    
    let langs  = Setting.langs
    
    var body: some View {
        VStack(spacing:20) {
            

                
                Picker("Select Lang",selection:$selectLang){
                    
                    
                    
                    ForEach(Array(langs.keys), id: \.self) { key in
                          
                              Text(langs[key] ?? "")
                          
                      }

                    
                }
                .onChange(of: selectLang) { newValue in
                    print(newValue)
                    Singleton.shared.selectedLang = newValue
                    
                    
                    
                }
  
            
            Button("Generate Random") {
                print("click")
                
                if let lang = langs["en-US"]{
                    print("\(lang)")
                }
               
//                speechRecognition.stopTranscribing()
                
                RandomNumber = Int.random(in: 1..<1000)
                
                voiceOut.readnumber(speech: String(RandomNumber))
                
//                speechRecognition.resetTranscript()
//
//                speechRecognition.startTranscribing()
                
                
                
                
                
            }
            .disabled(voiceOut.isTalk ? true:false)
            
            


            
            Text("\(RandomNumber)")
                .font(.title)
            
            Text("\(speechRecognition.message)")
                .font(.title)
            
            
            Button("Stop") {
                voiceOut.isTalk = false
                voiceOut.stop()
            }
            .disabled(voiceOut.isTalk ? false : true)
        }
        .padding()
        .onAppear{
            print("on appear")
            

            
        }
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
