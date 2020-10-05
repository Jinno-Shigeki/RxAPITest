//
//  Entity.swift
//  RxAPIList
//
//  Created by 神野成紀 on 2020/09/23.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import Foundation

struct Entity: Decodable {
    let items: [Items]
}

struct Items: Decodable {
    let login: String
}
