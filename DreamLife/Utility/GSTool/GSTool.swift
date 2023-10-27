//
//  GSTool.swift
//  DreamLife
//
//  Created by 曹国盛 on 2023/10/27.
//

import Foundation
import Toaster

struct GSTool {

    static func classNameAsString(obj: Any) -> String {
        return String(describing: type(of: obj))
    }

    static func show(text: String) {
        Toast(text: text).show()
    }

}
