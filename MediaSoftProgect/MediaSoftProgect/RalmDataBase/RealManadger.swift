//
//  RealManadger.swift
//  MediaSoftProgect
//
//  Created by Александр Логинов on 01.07.2022.
//

import RealmSwift

final class RealmManadger {
    
    static let shared = RealmManadger()
    private init(){}
    
    let realm = try! Realm()
    var gfycatDataBase: Results<RealmGfycatModel>!
    
    func itemsGfycat() -> [RealmGfycatModel] {
        
        let gfycatDataBase = realm.objects(RealmGfycatModel.self)
        return Array(gfycatDataBase)
    }
    
    func add(moedel: RealmGfycatModel) {
        do {
            try self.realm.write{
                self.realm.add(moedel)
            }
        } catch {
            print(error.localizedDescription)
        }
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
