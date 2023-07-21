//
//  SpeakingTrainingApp.swift
//  SpeakingTraining
//
//  Created by man ching chan on 10/7/2023.
//

import SwiftUI

@main
struct SpeakingTrainingApp: App {
    @StateObject private var vm = SpeakingViewModel()
    
    var body: some Scene {
        WindowGroup {
            //ContentView()
            
            StartView()
                .environmentObject(vm)
        }
    }
}
