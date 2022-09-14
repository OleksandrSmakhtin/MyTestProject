//
//  ApiManager.swift
//  MyTestProject
//
//  Created by Oleksandr Smakhtin on 14.09.2022.
//

import Foundation


class ApiManager {
    static let instance = ApiManager()
    
    // Example
    let apiUrl = "https://api.mysmartdoor.com/data...."
    let ApiChangeStatusUrl = "https://api.mysmartdoor.com/status...."
    
    let session = URLSession(configuration: .default)
    
    func getDoors(onSuccess: @escaping (Doors) -> Void, onError: @escaping (String) -> Void) {
        let url = URL(string: apiUrl)!
        let task = session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                
                guard let data = data, let  response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return }
                
                do {
                    if response.statusCode == 200{
                        // parse data
                        //let doors = try JSONDecoder().decode(DoorsForApiImit.self, from: data)
                        
                        // imitation
                        let doors = DoorData.instance.getDoors()
                        let data = Doors(doors: doors)
                        onSuccess(data)
                    }
                    
                } catch {
                    onError(error.localizedDescription)
                }
            }
        }
        task.resume()
        
        
        
    }
    
    
    
}
