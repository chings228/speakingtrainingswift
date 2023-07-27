//
//  Utils.swift
//  SpeakingTraining
//
//  Created by man ching chan on 21/7/2023.
//

import Foundation


struct Utils{
    
    static let langs  = [
        "en-US": "English",
        "zh-HK":"Chinese",
        "th-TH":"Thai",
        "jp-JP":"Japanese",
        "de-DE":"German"
    ]
    


    static let gameTimerCounterVal : Int = 8
    static let startCounterVal : Int = 5
    static let numOfQuestionVal : Int = 10
    static let idleTimerCounterVal : Int = 2
    
    
    static func convertToNumberReading(num:Int,locale:String)->String{
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        formatter.locale = Locale(identifier: locale)
        
        let text = formatter.string(from:num as NSNumber)
        
        guard let text = text else {return ""}
        
        return text
        
        
    }
    
}


enum PlayLevel:String,CaseIterable{

    case Beginner
    case Medium
    case Difficult

}

extension String {
    var isNumber: Bool {
        let digitsCharacters = CharacterSet(charactersIn: "0123456789")
        return CharacterSet(charactersIn: self).isSubset(of: digitsCharacters)
    }
}



