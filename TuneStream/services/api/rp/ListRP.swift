//
//  ListRp.swift
//  TuneStream
//
//  Created by SusantShrestha on 12/14/23.
//

import Foundation

struct ListRP<T : Codable>: Codable {
    let href: String
    let limit: Int
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int
    let items: [T]
}
