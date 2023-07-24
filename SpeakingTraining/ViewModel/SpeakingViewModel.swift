//
//  SpeakingViewModel.swift
//  SpeakingTraining
//
//  Created by man ching chan on 21/7/2023.
//

import Foundation




class SpeakingViewModel : ObservableObject{
    
    
    
     @Published  var languageSelect : String = "en-US"
    
    @Published var levelSelect : PlayLevel = .Beginner
    
    
    @Published var randomNumber : Int = 0

    
    func generateRandom(){
        
        if (levelSelect == .Beginner){
            
            
            randomNumber  = Int.random(in: 1...20)
            
            
        }
        else if (levelSelect == .Difficult){
            
            
            randomNumber = Int.random(in: 0...10000)
        }
        
      

        
    }
    
    
    
}
