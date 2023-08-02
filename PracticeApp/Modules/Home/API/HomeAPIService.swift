//
//  FetchJsonData.swift
//  PracticeApp
//
//  Created by Rohit Bharti on 27/07/23.
//

import Foundation

class HomeAPIService {
    
    func readJSONFile(forName name: String) -> [Users]? {
        do {
            // creating a path from the main bundle and getting data object from the path
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                // Decoding the Product type from JSON data using JSONDecoder() class.
                let data = try JSONDecoder().decode([Users].self, from: jsonData)
                return data
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    func fetchData(completionHandler: @escaping ([Users]) -> Void) {
        let url = URL(string: "https://api.github.com/repos/apple/swift/pulls?page=1&per_page=20")!
        
        var request = URLRequest(url: url)
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
                    let dataToReturn = try JSONDecoder().decode([Users].self, from: data)
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
