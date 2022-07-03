//
//  RealmAccessTokenModel.swift
//  MediaSoftProgect
//
//  Created by Александр Александров on 01.07.2022.
//

import Foundation

import RealmSwift

final class RealmAccessTokenModel: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var accessToken: String

    convenience init(accessToken: String) {
        self.init()
        self.accessToken = accessToken
    }
}
