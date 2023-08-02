//
//  ProfileApiService.swift
//  PracticeApp
//
//  Created by Rohit Bharti on 28/07/23.
//

import Foundation

class ProfileAPIService {
        
    func fetchData(userName: String, completionHandler: @escaping (Profile) -> Void) {
        let url = URL(string: "https://api.github.com/users/\(userName)")
        
        if let apiUrl = url {
            var request = URLRequest(url: apiUrl)
            request.addValue("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", forHTTPHeaderField: "Authorization")

            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let error = error {
                    print("Error with fetching Data: \(error)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Error with the response, unexpected status code: \(String(describing: response))")
                    return
                }
                
                do {
                    if let data = data {
                        let dataToReturn = try JSONDecoder().decode(Profile.self, from: data)
                        DispatchQueue.main.async(execute: { () -> Void in
                            completionHandler(dataToReturn)
                        })
                    }
                }
                catch {
                    print("Parse error \(error)")
                }
            })
            task.resume()
        }
    }
    
}
