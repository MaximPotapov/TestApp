//
//  ContentViewModel.swift
//  TestApp
//
//  Created by Maxim Potapov on 23.09.2021.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    
    private let getUrl = "https://api.foursquare.com/v2/venues/search"
    let clientId = "12FU3LQTEDE1GY1P2WBLZ0FWRGZGWIZVPEJMDLUTCPJGD0W3"
    let clientSecret = "VHDKSRYECGCEGNXD5JW0TOSOFVLRXZXVAIZPUYFWYM3IVOLF"
    
    @Published var items = [Venue]()
    @Published var venueName = ""
    
    func lodaData() {
        guard let url = URL(string: getUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let data = data {
                    let result = try JSONDecoder().decode([Venue].self, from: data)
                    
                    DispatchQueue.main.async {
                        self.items = result
                    }
                } else {
                    print("No data")
                }
            } catch (let error) {
                print(error.localizedDescription)
            }
        }.resume()
        
    }
    
    func snapToPlace() {
        let urlString = "https://api.foursquare.com/v2/venues/search?ll=\(LocationManager.shared.location),\(LocationManager.shared.location)&v=20160607&intent=checkin&limit=1&radius=4000&client_id=\(clientId)&client_secret=\(clientSecret)"
        
        guard
          let url = URL(string: urlString),
            ((try? Data(contentsOf: url)) != nil)
          else { return }
        
        let request = NSMutableURLRequest(url: url)

        let session = URLSession.shared
            
        request.httpMethod = "GET"
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, err -> Void in
                
                var currentVenueName:String?
    
                DispatchQueue.main.async {
                    if let v = currentVenueName {
                        self.venueName = "You're at \(v). Here's some ☕️ nearby."
                    }
                }
            })
            
            task.resume()
        }
}
