//
//  Singleton.swift
//  SpeakingTraining
//
//  Created by man ching chan on 18/7/2023.
//

import Foundation

class Singleton{
    
    static let shared = Singleton()
    
    var selectedLang = "en-US"
    
    private init(){}
    
    
}
