//
//  Category.swift
//  TuneStream
//
//  Created by SusantShrestha on 12/14/23.
//

import Foundation

struct Category: Codable {
    let href: String
    let icons: [Image]
    let id: String
    let name: String
}
