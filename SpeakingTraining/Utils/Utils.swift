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



