//
//  GSTool.swift
//  DreamLife
//
//  Created by 曹国盛 on 2023/10/27.
//

import Foundation
import Toaster

struct GSTool {
    ///需要传对象
    static func classNameAsString(obj: Any) -> String {
        return String(describing: type(of: obj))
    }

    static func show(text: String) {
        Toast(text: text).show()
    }

    static func showSheet(title: String = "", titleArray: [String], currentVC: UIViewController, clickBlock:@escaping (String)->()) {
        let alertCtrl = UIAlertController(title: title, message: "", preferredStyle: .actionSheet)
        for title in titleArray {
            let action = UIAlertAction(title: title, style: .default) { (action:UIAlertAction!) in
                clickBlock(title)
            }
            alertCtrl.addAction(action)
        }
        currentVC.present(alertCtrl, animated: true)
    }

    static func getTimeStamp() -> String {
        let date = Date()
        let currentTimeInterval = date.timeIntervalSince1970
        return String(currentTimeInterval)
    }


}
