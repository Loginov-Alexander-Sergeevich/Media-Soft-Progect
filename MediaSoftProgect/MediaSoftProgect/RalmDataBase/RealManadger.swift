//
//  RealManadger.swift
//  MediaSoftProgect
//
//  Created by Александр Александров on 01.07.2022.
//

import RealmSwift

final class RealmManadger {
    
    static let shared = RealmManadger()
    private init(){}
    
    let realm = try! Realm()
    var tokenDataBase: Results<RealmAccessTokenModel>!
    let itemPhotoDataBase = RealmAccessTokenModel()
    
    func accessToken() -> [RealmAccessTokenModel] {
        tokenDataBase = realm.objects(RealmAccessTokenModel.self)
        let items = self.tokenDataBase
        return Array(items!)
    }
    
    func addAccessToken(accessToken: String) {
        
        let item = RealmAccessTokenModel(accessToken: accessToken)
        
        do {
            try self.realm.write{
                self.realm.add(item)
            }
        } catch {
            print(error.localizedDescription)
        }
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
//    func deleteItem(at id: ObjectId) {
//        
//        photoDataBase = realm.objects(PhotoInfoDB.self)
//        
//        if let objct = photoDataBase.filter("_id = %@", id as Any).first {
//            try! realm.write {
//                realm.delete(objct)
//            }
//        }
//    }
}
