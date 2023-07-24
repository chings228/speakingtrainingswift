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
    @AppStorage("selectLevel") private var appStorageSelectLevel:PlayLevel =  .Beginner

    
    var body: some View {
        
        
        NavigationView {
            VStack(spacing:30){
                Text("Speaking Training")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                
                
                    
                    
                gameConfigView

                //startBtnView
                

                NavigationLink {
                    GameView()
                } label: {

                        Text("Start")
                            .padding()
                            .font(.title)
                            .fontWeight(.bold)
                            .background(Color.blue)
                            .cornerRadius(20)
                            .foregroundColor(.white)
                    

                }

                
                
            }
            
        }
        .onAppear{
            vm.languageSelect = appStorageSelectLang
            vm.levelSelect = appStorageSelectLevel
            
        }

        
    }
}


extension StartView{
    
    
    private var startBtnView : some View{
        
        
        

        
         Button {
            print("start")

        } label: {
            Text("Start")
                .padding()
                .font(.title)
                .fontWeight(.bold)
            
        }
        .background(Color.blue)
        .cornerRadius(20)
        .foregroundColor(.white)
        

        
        
    }
    
    
    
   private var gameConfigView : some View{
        
        VStack(spacing:10){
            Text("Select Language")
                .font(.title)
           
            Picker("Select Language",selection:$vm.languageSelect){
                
                
                
                ForEach(Array(Utils.langs.keys), id: \.self) { key in
                    
                    Text(Utils.langs[key] ?? "")
                    
                }
                
                
            }
            .scaleEffect(1.5)
            .onChange(of: vm.languageSelect) { newValue in
                print("on change new lang \(newValue)")
                appStorageSelectLang = newValue
            }
            
            Rectangle()
                .frame(height:14)
                .background(Color.clear)
                .foregroundColor(.clear)
            
            
            Text("Select Level")
                .font(.title)
            Picker("Select Level",selection:$vm.levelSelect){
                
                ForEach(PlayLevel.allCases, id:\.self){ option in
                    Text(String(describing: option))
                }
            }
            .scaleEffect(1.5)
            .onChange(of: vm.levelSelect) { newValue in
                
                print(newValue)
                appStorageSelectLevel = newValue
            }
            
            
        }
        
        
    }

    
}




struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
            .environmentObject(SpeakingViewModel())
    }
}
