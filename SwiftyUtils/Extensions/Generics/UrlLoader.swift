//
//  UrlLoader.swift
//  SwiftyUtils
//
//  Created by Anton Poltoratskyi on 05.08.17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

private let webServiceURL = URL(string: "")!

struct Resource<A> {
    let path: String
    let parse: (Any) -> A?
}
extension Resource {
    func loadSynchronously(callback: (A?) -> Void) {
        let resourceURL = webServiceURL.appendingPathComponent(self.path)
        let data = try? Data(contentsOf: resourceURL)
        let json = data.flatMap {
            try? JSONSerialization.jsonObject(with: $0, options: [])
        }
        callback(json.flatMap(parse))
    }
    
    func loadAsynchronously(callback: @escaping (A?) -> Void) {
        let resourceURL = webServiceURL.appendingPathComponent(self.path)
        let session = URLSession.shared
        session.dataTask(with: resourceURL) { data, urlResponse, error in
            let json = data.flatMap {
                try? JSONSerialization.jsonObject(with: $0, options: [])
            }
            callback(json.flatMap(self.parse))
        }.resume()
    }
}

func jsonArray<A>(_ transform: @escaping (Any) -> A?) -> (Any) -> [A]? {
    return { array in
        guard let array = array as? [Any] else {
            return nil
        }
        return array.flatMap(transform)
    }
}

class User {
    init(_ json: Any) { }
}

private func test() {
    let userResource: Resource<[User]> = Resource(path: "/users", parse: jsonArray(User.init))
    userResource.loadAsynchronously { users in
        print(users)
    }
}
