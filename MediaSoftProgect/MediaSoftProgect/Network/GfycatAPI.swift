//
//  GfycatAPI.swift
//  MediaSoftProgect
//
//  Created by Александр Александров on 01.07.2022.
//

import Foundation
import Moya

enum GfycatAPI {
    case stickers
    case login(client_id: String, client_secret: String, grant_type: String)
    case searchPoster(name: String)
}

extension GfycatAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.gfycat.com")!
    }
    
    var path: String {
        switch self {
            
        case .login:
            return "/v1/oauth/token"
        case .searchPoster:
            return "/v1/gfycats/search"
        case .stickers:
            return "/v1/stickers"
        }
    }
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
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
        case .login(let client_id, let client_secret, let grant_type):
            let params: [String: Any] = ["client_id": client_id, "client_secret": client_secret, "grant_type": grant_type]
            return .requestData(try! JSONSerialization.data(withJSONObject: params, options: []))
            
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
