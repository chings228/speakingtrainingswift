//
//  VoiceOut.swift
//  SpeakingTraining
//
//  Created by man ching chan on 10/7/2023.
//

import Foundation
import AVFoundation





class VoiceOut : NSObject,ObservableObject{

    @Published var isTalk = false
    
    
    let synth = AVSpeechSynthesizer()
  
    
    override init(){
        super.init()
        synth.delegate = self
    }
    
    
    func readnumber(lang:String ,speech : String ){
        
        
        
        isTalk = true
        
        let utterance = AVSpeechUtterance(string:speech)
      
        utterance.pitchMultiplier = 1.0
        utterance.rate = 0.5
        utterance.voice = AVSpeechSynthesisVoice(language: lang)
        utterance.volume = 10
        
        print(Singleton.shared.selectedLang)
        
        print(utterance.speechString)
      
        synth.speak(utterance)

        
    }
    
    
    func stop(){
        
        synth.stopSpeaking(at: .immediate)
        
        isTalk = false
        
        print(isTalk)
        
        
    }
    
    
    
    
}

extension VoiceOut:AVSpeechSynthesizerDelegate{
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        print("did start ")
    }
    
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        
        isTalk = false
        print("did finish")
        
        print(isTalk)
    }
    
    
}
