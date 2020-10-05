//
//  ViewModel.swift
//  RxAPIList
//
//  Created by 神野成紀 on 2020/09/23.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ViewModel {
    private let searchWord = PublishSubject<String>()
    
    var searchWordObserver: AnyObserver<String> {
        return searchWord.asObserver()
    }
    
    let userOvservable: Driver<[Items]>
    
    init() {
        userOvservable = searchWord.flatMapLatest { word -> Observable<Entity> in
            print(word)
            let model = APIClient()
            return model.fetchData(word: word)
        }.map { $0.items }
        .asDriver(onErrorJustReturn: [])
    }
}
