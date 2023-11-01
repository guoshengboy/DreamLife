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
    var dealID: String = ""//交易 ID ，创建记录生成的唯一标识
    var fatherID: String = "" //只针对买和卖、初始买为空
    var isFirstInitialBuy: Bool = false

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
        case dealID = "dealID"
        case fatherID = "fatherID"
        case initBuyCount = "initBuyCount"
        case buyPrice = "buyPrice"
        case buyCount = "buyCount"
        case sellPrice = "sellPrice"
        case sellCount = "sellCount"
        case isFirstInitialBuy = "isFirstInitialBuy"


        static let objectRelationalMapping = TableBinding(CodingKeys.self){
            BindColumnConstraint(fundName, isNotNull: true, defaultTo: "")
            BindColumnConstraint(fundCode, isNotNull: true, defaultTo: "")
            BindColumnConstraint(addDate, isNotNull: true, defaultTo: "")
            BindColumnConstraint(dealType, isNotNull: true, defaultTo: 1)
            BindColumnConstraint(dealStatus, isNotNull: true, defaultTo: 1)
            BindColumnConstraint(dealID, isNotNull: true, defaultTo: "")
            BindColumnConstraint(fatherID, isNotNull: true, defaultTo: "")
            BindColumnConstraint(initBuyCount, isNotNull: true, defaultTo: "0")
            BindColumnConstraint(buyPrice, isNotNull: true, defaultTo: "0")
            BindColumnConstraint(buyCount, isNotNull: true, defaultTo: "0")
            BindColumnConstraint(sellPrice, isNotNull: true, defaultTo: "0")
            BindColumnConstraint(sellCount, isNotNull: true, defaultTo: "0")
            BindColumnConstraint(isFirstInitialBuy, isNotNull: true, defaultTo: false)
        }
    }

    ///是否存在第一次初始买的
    static func isExistFirstInitialBuy(code: String) -> Bool {
        //先获取初始买的数据(进行中)
        let initBuyArray = DBManager.shareManager.getObjects(cls: self, where: FundDealModel.Properties.fundCode == code && FundDealModel.Properties.dealType == DealType.initialBuy.rawValue && FundDealModel.Properties.dealStatus == DealStatusType.underway.rawValue)
        if initBuyArray.count == 0 {
            return false
        }
        return true
    }

    
    static func getFirstInitialBuy(code: String) -> FundDealModel? {
        //先获取初始买的数据(进行中)
        let initBuyArray = DBManager.shareManager.getObjects(cls: self, where: FundDealModel.Properties.fundCode == code && FundDealModel.Properties.dealType == DealType.initialBuy.rawValue && FundDealModel.Properties.dealStatus == DealStatusType.underway.rawValue && FundDealModel.Properties.isFirstInitialBuy == true)
        if initBuyArray.count == 0 {
            return nil
        }
        return initBuyArray[0]
    }

    static func getSubarray(model: FundDealModel) -> [FundDealModel] {
        let array = DBManager.shareManager.getObjects(cls: self, where: FundDealModel.Properties.fatherID == model.dealID && (FundDealModel.Properties.dealType == DealType.buy.rawValue ||
            FundDealModel.Properties.dealType == DealType.sell.rawValue) && FundDealModel.Properties.dealStatus == DealStatusType.plan.rawValue)
        return array.sorted { model1, model2 in
            let price1 = model1.dealType == DealType.buy.rawValue ? (Double(model1.buyPrice) ?? 0) : (Double(model1.sellPrice) ?? 0)
            let price2 = model2.dealType == DealType.buy.rawValue ? (Double(model2.buyPrice) ?? 0) : (Double(model2.buyPrice) ?? 0)
            return price1 > price2
        }
    }
}

