//
//  FavoritPosterViewModel.swift
//  MediaSoftProgect
//
//  Created by Александр Логинов on 01.07.2022.
//

import Foundation
import Realm
import RealmSwift

protocol FavoritPosterViewModelProtocol {
    var timer: Timer? {get set}
    var title: String {get set}
    func deletDataPhoto(id: ObjectId)
}

final class FavoritPosterViewModel: FavoritPosterViewModelProtocol {
    
    var title: String = "Favourite posters"
    
    var timer: Timer?
    
    func deletDataPhoto(id: ObjectId) {
        RealmManadger.shared.deletet(at: id)
    }
}
