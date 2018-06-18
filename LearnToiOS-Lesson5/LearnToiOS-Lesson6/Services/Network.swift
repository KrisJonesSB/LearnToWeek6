//
//  Network.swift
//  LearnToiOS-Lesson5
//
//  Created by Jack Spargo on 09/06/2018.
//  Copyright © 2018 LearnTo iOS. All rights reserved.
//

import Foundation

class Network {

    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?

    func getData(completion: @escaping (Data) -> Void) {
        dataTask?.cancel()
        if var urlComponents = URLComponents(string: "https://api.github.com/search/repositories") {
            urlComponents.query = "q=language:swift"
            guard let url = urlComponents.url else { return }

            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                if let error = error {
                    print("DataTask error: " + error.localizedDescription)
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    completion(data)
                }
            }
            dataTask?.resume()
        }
    }
}
