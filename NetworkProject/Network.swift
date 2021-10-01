//
//  Network.swift
//  NetworkProject
//
//  Created by Данила Бондаренко on 01.10.2021.
//

import Foundation

enum ObtainPostsResault {
    case success(posts: [Post])
    case fail(error: Error)
}

class Network {
    let sessionConfiguration = URLSessionConfiguration.default
    let decoder = JSONDecoder()
    
    func obtainPosts(completion: @escaping (ObtainPostsResault) -> Void) {
        let session = URLSession.shared
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        session.dataTask(with: url) { [weak self] (data, response, error) in

            let result: ObtainPostsResault

            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }

            guard let strongSelf = self else {
                result = .success(posts: [])
                return
            }

            if error == nil, let parseData = data {
                guard let posts = try? strongSelf.decoder.decode([Post].self, from: parseData) else {
                    result = .success(posts: [])
                    return
                }
                result = .success(posts: posts)
            } else {
                result = .fail(error: error!)
            }

        }.resume()
        
    }
}
