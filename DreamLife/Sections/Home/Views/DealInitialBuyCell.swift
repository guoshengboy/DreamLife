//
//  DealInitialBuyCell.swift
//  DreamLife
//
//  Created by 曹国盛 on 2023/10/31.
//

import Foundation
import UIKit

class DealInitialBuyCell: UITableViewCell {

    @IBOutlet weak var fundNameLab: UILabel!
    @IBOutlet weak var buyDateLab: UILabel!
    @IBOutlet weak var buyPriceLab: UILabel!
    @IBOutlet weak var buyCountLab: UILabel!
    @IBOutlet weak var dealStatusLab: UILabel!
    @IBOutlet weak var dealTypeLab: UILabel!


    func setupCell(model: FundDealModel) {

        fundNameLab.text = model.fundName

        if model.dealStatus == DealStatusType.plan.rawValue{
            buyDateLab.text = "购买日期：无"
        }else{
            buyDateLab.text = "购买日期：\(model.addDate)"
        }

        buyPriceLab.text = "购买价格：\(model.buyPrice)"
        buyCountLab.text = "购买数量：\(model.buyCount)"

        var dealStatusStr = ""
        if model.dealStatus == DealStatusType.underway.rawValue{
            dealStatusStr = "进行中"
        }else if model.dealStatus == DealStatusType.finish.rawValue {
            dealStatusStr = "已结束"
        }else if model.dealStatus == DealStatusType.plan.rawValue {
            dealStatusStr = "计划"
        }
        dealStatusLab.text = dealStatusStr

        var dealTypeStr = ""
        if model.dealType == DealType.initialBuy.rawValue {
            dealTypeStr = "初始买"
        }else if model.dealType == DealType.buy.rawValue {
            dealTypeStr = "买"
        }else if model.dealType == DealType.sell.rawValue {
            dealTypeStr = "卖"
        }
        dealTypeLab.text = dealTypeStr
    }

}
