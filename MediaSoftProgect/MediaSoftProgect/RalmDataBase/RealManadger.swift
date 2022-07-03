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
    var gfycatDataBase: Results<RealmGfycatModel>!

    
    
    
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
        //print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    func itemsGfycat() -> [RealmGfycatModel] {
        
        let gfycatDataBase = realm.objects(RealmGfycatModel.self)
        //let items = gfycatDataBase
        return Array(gfycatDataBase)
    }
    
    func add(moedel: RealmGfycatModel) {
        
        
        //let item = RealmGfycatModel(posterUrl: posterUrl, title: title)
        
        
        do {
            try self.realm.write{
                self.realm.add(moedel)
            }
        } catch {
            print(error.localizedDescription)
        }
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    

    
    func deletet(at id: ObjectId) {

        let gfycatDataBase = realm.objects(RealmGfycatModel.self)
        
        if let objct = gfycatDataBase.filter("_id = %@", id as Any).first {
            try! realm.write {
                realm.delete(objct)
            }
        }
    }
    
    
    func deletBD() {
        try! realm.write({
            realm.deleteAll()
        })
    }
}
