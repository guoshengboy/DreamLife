//
//  FundModel.swift
//  DreamLife
//
//  Created by 曹国盛 on 2023/10/26.
//

import Foundation
import ObjectMapper

struct FundModel: Mappable {
    var fundName: String = ""
    var fundCode: String = ""
    var addDate: String = ""

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        fundName   <- map["fundName"]
        fundCode   <- map["fundCode"]
        addDate   <- map["addDate"]
    }
}
