//
//  FundModel.swift
//  DreamLife
//
//  Created by 曹国盛 on 2023/10/26.
//

import Foundation
import WCDBSwift

class FundModel: TableCodable {

    var fundName: String = ""
    var fundCode: String = ""
    var addDate: String = ""

    enum CodingKeys: String, CodingTableKey {
        typealias Root = FundModel

        case fundName = "fundName"
        case fundCode = "fundCode"
        case addDate = "addDate"

        static let objectRelationalMapping = TableBinding(CodingKeys.self){
            BindColumnConstraint(fundName, isNotNull: true, defaultTo: "")
            BindColumnConstraint(fundCode, isNotNull: true, isUnique: true, defaultTo: "")
            BindColumnConstraint(addDate, isNotNull: true, defaultTo: "")
        }
    }
}

