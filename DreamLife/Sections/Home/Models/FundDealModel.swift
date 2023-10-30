//
//  FundDealModel.swift
//  DreamLife
//
//  Created by 曹国盛 on 2023/10/30.
//

import Foundation
import WCDBSwift

enum DealType: Int {
    case initialBuy = 1
    case buy = 2
    case sell = 3
}

enum DealStatusType: Int {
    case underway = 1//进行中
    case finish = 2 //结束
    case plan = 3//计划
}

class FundDealModel: TableCodable {

    var fundName: String = ""
    var fundCode: String = ""
    var addDate: String = ""
    var dealID: Int = 1 //从开始到结束的唯一标识  以后依次增加
    var dealType: DealType = .initialBuy //交易类型
    var dealStatus:DealStatusType = .underway //交易状态
    var initBuyID: String = ""//针对初始买的交易  会生成唯一标识
    var initBuyCount: Int = 0 //初始购买的个数 这个不会进行加减操作 只是记录

    var fatherBuyID: String = ""//针对在初始买的下面买卖的交易  会把initBuyID赋予此字段
    var planBuyPrice: String = ""
    var planBuyCount: String = ""
    var buyPrice: String = ""
    var buyCount: String = ""
    var planSellPrice: String = ""
    var planSellCount: String = ""
    var sellPrice: String = ""
    var sellCount: String = ""


    enum CodingKeys: String, CodingTableKey {
        typealias Root = FundDealModel

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

