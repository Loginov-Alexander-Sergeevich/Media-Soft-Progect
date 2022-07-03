//
//  Extension + UIStackView.swift
//  MediaSoftProgect
//
//  Created by Александр Логинов on 01.07.2022.
//

import Foundation
import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ items: [UIView]) {
        
        for item in items {
            addArrangedSubview(item)
        }
    }
}
