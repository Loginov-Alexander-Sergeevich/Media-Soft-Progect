//
//  Extension + UIView.swift
//  MediaSoftProgect
//
//  Created by Александр Логинов on 01.07.2022.
//

import Foundation
import UIKit

extension UIView {
    
    func addSubviews(_ items: [UIView]) {
        for item in items {
            addSubview(item)
        }
    }
}
