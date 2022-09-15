//
//  ApiManager.swift
//  MyTestProject
//
//  Created by Oleksandr Smakhtin on 14.09.2022.
//

import Foundation

protocol ApiGetDelegate {
    func didLoadDoors(_ apiManager: ApiManager, doors: [Door])
}

protocol ApiChangeStatusDelegate {
    func didChangeStatus(_ apiManager: ApiManager, status: String, index: Int)
}


struct ApiManager {
    var getDelegate: ApiGetDelegate?
    var changeStatusDelegate: ApiChangeStatusDelegate?
    // Example url
    let apiUrl = "https://api.mysmartdoor.com"

    // fetch get data imitation
    func fetchDoors() {
        let correctUrl = "\(apiUrl)/data/for/user/oleksandrsmakhtin"
        performGetRequest(urlString: correctUrl)
    }
    
    // fetch write data imitation
    func fetchStatus(status: String, index: Int) {
        let correctUrl = "\(apiUrl)/status/change/for/user/oleksandrsmakhtin"
        performStatusRequest(urlString: correctUrl, status: status, index: index)
    }
    
    
//MARK: - Fetch Get Request
    func performGetRequest(urlString: String) {
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
                        getDelegate?.didLoadDoors(self, doors: doors)
                    }
                }
            }
            task.resume()
        }
    }
    
    
//MARK: - Status Change Request
    func performStatusRequest(urlString: String, status: String, index: Int) {
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            let session = URLSession(configuration: .default)
            request.httpMethod = "PUT"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            do {
                //imitation
                let body = try JSONEncoder().encode(status)
                request.httpBody = body
                
                let task = session.dataTask(with: request) { data, response, error in
                    // imitated data, error, response
                    let imitError: Error? = nil
                    let imitData: [Door]? = DoorData.instance.getDoors()
                    let imitResponse: URLResponse
                    let imitResponseStatusCode = 200
                    
                    if imitError != nil {
                        print(imitError?.localizedDescription)
                    }
                    
                    guard let safeData = imitData /*let response = imitResponse as? HTTPURLResponse*/ else {
                        print("Error - in performStatusRequest data response check")
                        return
                    }
                    
                    do {
                        if imitResponseStatusCode == 200 {
                            changeStatusDelegate?.didChangeStatus(self, status: status, index: index)
                        } else {
                            print("status code error")
                        }
                    } catch {
                        print("change status error")
                    }
                    
                    
                    
                }
            } catch {
                print("Request error")
            }
            
            
            
            
            
        }
        
        
    }
    
//MARK: - JSON parsers
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
