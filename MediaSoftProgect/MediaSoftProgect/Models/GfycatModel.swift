//
//  GfycatModel.swift
//  MediaSoftProgect
//
//  Created by Александр Логинов on 01.07.2022.
//

import Foundation

struct GfycatModel: Codable, Hashable {
    let cursor: String?
    let gfycats: [Gfycats]?
    let related: [String]?
    let found: Int?
}

// MARK: - Gfycat
struct Gfycats: Codable, Hashable {

    let title: String?
    let mobilePosterUrl: String?

}
