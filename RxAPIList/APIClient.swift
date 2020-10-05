//
//  APIClient.swift
//  RxAPIList
//
//  Created by 神野成紀 on 2020/09/23.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class APIClient {
    func fetchData (word: String) -> Observable<Entity> {
        return Observable.create { (observer) in
            let urlString = "https://api.github.com/search/users?q=\(word)"
            if let url = URL(string: urlString) {
                
                let session = URLSession.shared
                let dataTask = session.dataTask(with: url) { (data, responce, error) in
                    guard let safeData = data else { return print("エラー") }
                    do {
                        let decodeData = try JSONDecoder().decode(Entity.self, from: safeData)
                        observer.onNext(decodeData)
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }
                }
                dataTask.resume()
            }
            return Disposables.create()
        }
    }
}
