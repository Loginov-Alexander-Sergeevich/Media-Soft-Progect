//
//  GfycatAPI.swift
//  MediaSoftProgect
//
//  Created by Александр Логинов on 01.07.2022.
//

import Foundation
import Moya

enum GfycatAPI {
    case stickers
    case searchPoster(name: String)
}

extension GfycatAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.gfycat.com")!
    }
    
    var path: String {
        switch self {
        case .searchPoster:
            return "/v1/gfycats/search"
        case .stickers:
            return "/v1/stickers"
        }
    }
    var method: Moya.Method {
        switch self {
        case .searchPoster:
            return .get
        case .stickers:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {

        switch self {
        case .searchPoster(let name):
            let params: [String: Any] = ["search_text": name]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        case .stickers:
            let params: [String: Any] = ["count": 30]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type" : "application/json"]
    }
}
