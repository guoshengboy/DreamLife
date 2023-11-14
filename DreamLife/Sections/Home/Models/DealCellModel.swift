//
//  DealCellModel.swift
//  DreamLife
//
//  Created by 曹国盛 on 2023/11/13.
//

import Foundation
import UIKit

enum  DealCellEventType{
    case none //空
    case date //点击日期
    case status //交易状态
}

class DealCellModel {
    var cellType: String = ""
    var title: String = ""
    var value: String = ""
    var value2: String = ""
    var placeholder: String = ""
    var keyboardType: UIKeyboardType = .default
    var eventType: DealCellEventType = .none


    static func getModelWithTV(title: String, value: String) -> DealCellModel {
        let model = DealCellModel()
        model.cellType = "TV"
        model.title = title
        model.value = value
        return model
    }

    static func getModelWithTF(title: String, value: String, placeholder: String, keyboardType: UIKeyboardType = .default) -> DealCellModel {
        let model = DealCellModel()
        model.cellType = "TF"
        model.title = title
        model.value = value
        model.placeholder = placeholder
        model.keyboardType = keyboardType
        return model
    }

    static func getModelWithTB(title: String, value: String, type: DealCellEventType) -> DealCellModel {
        let model = DealCellModel()
        model.cellType = "TB"
        model.title = title
        model.value = value
        model.eventType = type
        return model
    }

    static func getModelWithTC(title: String, value: String, value2: String, placeholder: String, keyboardType: UIKeyboardType = .default) -> DealCellModel {
        let model = DealCellModel()
        model.cellType = "TC"
        model.title = title
        model.value = value
        model.value2 = value2
        model.placeholder = placeholder
        model.keyboardType = keyboardType
        return model
    }
}
