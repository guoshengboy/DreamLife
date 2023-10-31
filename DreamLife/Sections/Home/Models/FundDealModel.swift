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

    /****公共参数****/
    var fundName: String = ""
    var fundCode: String = ""
    var addDate: String = ""
    var dealType: Int = DealType.initialBuy.rawValue //交易类型
    var dealStatus:Int = DealStatusType.underway.rawValue //交易状态
    var buyID: String = ""//针对够买的交易会生成唯一标识、针对卖来说 用来寻找属于哪一个购买操作

    /****初始买****/
    var initBuyCount: Int = 0 //初始购买的个数 这个不会进行加减操作 只是记录

    /****买****/
    var buyPrice: String = ""
    var buyCount: String = ""

    /****卖****/
    var sellPrice: String = ""
    var sellCount: String = ""

    enum CodingKeys: String, CodingTableKey {
        typealias Root = FundDealModel

        case fundName = "fundName"
        case fundCode = "fundCode"
        case addDate = "addDate"
        case dealType = "dealType"
        case dealStatus = "dealStatus"
        case buyID = "buyID"
        case initBuyCount = "initBuyCount"
        case buyPrice = "buyPrice"
        case buyCount = "buyCount"
        case sellPrice = "sellPrice"
        case sellCount = "sellCount"


        static let objectRelationalMapping = TableBinding(CodingKeys.self){
            BindColumnConstraint(fundName, isNotNull: true, defaultTo: "")
            BindColumnConstraint(fundCode, isNotNull: true, isUnique: true, defaultTo: "")
            BindColumnConstraint(addDate, isNotNull: true, defaultTo: "")
            BindColumnConstraint(dealType, isNotNull: true, defaultTo: 1)
            BindColumnConstraint(dealStatus, isNotNull: true, defaultTo: 1)
            BindColumnConstraint(buyID, isNotNull: true, defaultTo: "")
            BindColumnConstraint(initBuyCount, isNotNull: true, defaultTo: "0")
            BindColumnConstraint(buyPrice, isNotNull: true, defaultTo: "0")
            BindColumnConstraint(buyCount, isNotNull: true, defaultTo: "0")
            BindColumnConstraint(sellPrice, isNotNull: true, defaultTo: "0")
            BindColumnConstraint(sellCount, isNotNull: true, defaultTo: "0")
        }
    }
}

