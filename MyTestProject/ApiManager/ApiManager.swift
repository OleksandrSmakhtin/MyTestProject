//
//  ApiManager.swift
//  MyTestProject
//
//  Created by Oleksandr Smakhtin on 14.09.2022.
//

import Foundation

protocol ApiManagerDelegate {
    func didLoadDoors(_ apiManager: ApiManager, doors: [Door])
}

struct ApiManager {
    var delegate: ApiManagerDelegate?
    
    // Example url
    let apiUrl = "https://api.mysmartdoor.com"

    // fetch imitation
    func fetchDoors() {
        let correctUrl = "\(apiUrl)/data/for/user/oleksandrsmakhtin"
        performRequest(urlString: correctUrl)
    }
    
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                // imitated data, error
                let imitError: Error? = nil
                let imitData: [Door]? = DoorData.instance.getDoors()
                
                if imitError != nil {
                    print(imitError?.localizedDescription)
                    return
                }
                
                if let safeData = imitData {
                    if let doors = parseJSON(apiData: safeData) {
                        delegate?.didLoadDoors(self, doors: doors)
                    }
                }
                
                
                
            }
            task.resume()
        }
    }
    
//MARK: - JSON parser
                        // imitation (real case type = Data)
    func parseJSON(apiData: [Door]) -> [Door]? {
        let decoder = JSONDecoder()
        do {
            // if real case
            //let decodedData = try decoder.(Door.self, from: apiData)
            
            // imitation
            let decodedData = apiData
            return decodedData
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

}
