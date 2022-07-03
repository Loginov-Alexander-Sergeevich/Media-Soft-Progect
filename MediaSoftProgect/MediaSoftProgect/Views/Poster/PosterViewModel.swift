//
//  PosterViewModel.swift
//  MediaSoftProgect
//
//  Created by Александр Логинов on 01.07.2022.
//

import Foundation
import Moya

enum Section: Int, CaseIterable {
    case poster
}

protocol PosterViewModelProtocol {
    var resultRequestGfycat: [Gfycats] {get set}
    var title: String {get set}
    var timer: Timer? {get set}
    
    func searchPoster(name: String, completion: @escaping() -> ())
    func requestPoster(completion: @escaping () -> ())
    func saveDataInRealmBD(model: RealmGfycatModel)
}

final class PosterViewModel: PosterViewModelProtocol {

    let provider = MoyaProvider<GfycatAPI>()
    var timer: Timer?
    var title: String = "Posters"
    
    var resultRequestGfycat: [Gfycats] = []
    
    func searchPoster(name: String, completion: @escaping () -> ()) {
        provider.request(.searchPoster(name: name)) { result in
            
            self.resultRequestGfycat.removeAll()
            
            switch result {
            case .success(let response):
                do {
                    let results = try response.map(GfycatModel.self).gfycats

                    guard let results = results else {return}

                    self.resultRequestGfycat = results
                    
                    completion()
                    
                } catch {
                    print(error)
                }

            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestPoster(completion: @escaping () -> ()) {
        provider.request(.stickers) { result in
            print(result)
            switch result {
                
            case .success(let response):
                do {
                    let results = try response.map(GfycatModel.self).gfycats
                    
                    guard let results = results else {return}

                    self.resultRequestGfycat = results
                    
                    completion()
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func saveDataInRealmBD(model: RealmGfycatModel) {
        
        RealmManadger.shared.add(moedel: model)
    }
}
