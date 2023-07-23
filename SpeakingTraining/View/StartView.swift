//
//  StartView.swift
//  SpeakingTraining
//
//  Created by man ching chan on 21/7/2023.
//

import SwiftUI

struct StartView: View {
    
    @EnvironmentObject var vm : SpeakingViewModel
    
    @AppStorage("selectLang") private var appStorageSelectLang =  "en-US"
    
    var body: some View {
        
        
        VStack(spacing:30){
            Text("Speaking Training")
                .fontWeight(.bold)
                .font(.largeTitle)
            
            
                
            VStack(spacing:10){
                Text("Select Language")
                    .font(.title)
                Section{
                    Picker("Select Language",selection:$vm.languageSelect){
                        
                        
                        
                        ForEach(Array(Utils.langs.keys), id: \.self) { key in
                            
                            Text(Utils.langs[key] ?? "")
                            
                        }
                        
                        
                    }
                    .scaleEffect(1.5)
                }
                .onChange(of: vm.languageSelect) { newValue in
                    appStorageSelectLang = newValue
                }
                
                Section{
                    Picker("Select Language",selection:$vm.languageSelect){
                        
                        
                        
                        ForEach(Array(Utils.langs.keys), id: \.self) { key in
                            
                            Text(Utils.langs[key] ?? "")
                            
                        }
                        
                        
                    }
                    .scaleEffect(1.5)
                }
                .onChange(of: vm.languageSelect) { newValue in
                    appStorageSelectLang = newValue
                }
            }
            
        }
        .onAppear{
            vm.languageSelect = appStorageSelectLang
        }

        
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
            .environmentObject(SpeakingViewModel())
    }
}
