//
//  RealmGfycatModel.swift
//  MediaSoftProgect
//
//  Created by Александр Логинов on 01.07.2022.
//

import Foundation
import RealmSwift

final class RealmGfycatModel: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var posterUrl: String
    @Persisted var title: String

    convenience init(posterUrl: String, title: String) {
        self.init()
        self.posterUrl = posterUrl
        self.title = title
    }
}
