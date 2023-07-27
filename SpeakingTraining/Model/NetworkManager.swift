//
//  NetworkManager.swift
//  SpeakingTraining
//
//  Created by man ching chan on 27/7/2023.
//

import Foundation


class NetworkManager : ObservableObject{
    
    
    @Published var returndata = ""
    
    public var link : String = ""
    public var query : String = ""
    
    func postData(){
        
        
        // Encode your JSON data
        //let jsonString = "{ \"command\" : \"sdm.devices.commands\", \"params\" : { \"commandName\" : \"cmdValue\" } }"
        
        
        let jsonString = "aaabbbb=cccccc&dddd=eeekkeeee"
        guard let jsonData = jsonString.data(using: .utf8) else { return }
        
        
        
        
        print(jsonData)
        
        // Send request
        guard let url = URL(string: "https://usa.1328.hk/swiftest.php") else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        // if need $_REQUEST , then use x-www-form-urlencoded
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.setValue("token", forHTTPHeaderField: "Authorization") // Most likely you want to add some token here
        // request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                // Handle HTTP request error
                
            } else if let data = data {
                // Handle HTTP request response
                print(data.description)
                
                guard let outputStr  = String(data: data, encoding: String.Encoding.utf8) else {return}
                print(outputStr)
               
            } else {
                // Handle unexpected error
            }
        }
        task.resume()
        
        
        
    }
    
    
    
    
    
    
}
