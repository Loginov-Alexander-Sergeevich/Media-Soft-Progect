//
//  LoginViewModel.swift
//  MediaSoftProgect
//
//  Created by Александр Александров on 01.07.2022.
//

import Foundation
import Moya

protocol LoginViewModelProtocol {
    var resultGfycat: AccessTokenModel? {get set}
    func requestGfycat(client_id: String, client_secret: String, grant_type: String)
}

final class LoginViewModel: LoginViewModelProtocol {
    var resultGfycat: AccessTokenModel?
    let provider = MoyaProvider<GfycatAPI>()
    
    //"2_79mpfg"
    //"b1XcX5uVeGrb0El-5_cW8Of1npacPSHPP2cWONauffZHrHnuTwUGTMRXwLltthEX"
    func requestGfycat(client_id: String, client_secret: String, grant_type: String) {
        provider.request(GfycatAPI.login(client_id: client_id, client_secret: client_secret, grant_type: grant_type)) { result in
            switch result {
            case .success(let response):
                do {
                    let results = try response.map(AccessTokenModel.self)
                    
                    guard let results = results.access_token else {return}
                    print(results)
                    
                    RealmManadger.shared.addAccessToken(accessToken: results)
                    
                } catch {
                    print("MoyaError.jsonMapping(result) = \(MoyaError.jsonMapping(response))")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
