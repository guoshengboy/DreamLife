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


    func setupCell(initialBuy model: FundDealModel) {

        fundNameLab.text = model.fundName
        fundNameLab.textColor = .red
        fundNameLab.font = UIFont.boldSystemFont(ofSize: 18)

        if model.dealStatus == DealStatusType.plan.rawValue{
            buyDateLab.text = "购买日期：无"
        }else{
            buyDateLab.text = "购买日期：\(model.addDate)"
        }
        buyDateLab.textColor = .red
        buyDateLab.font = UIFont.boldSystemFont(ofSize: 18)

        buyPriceLab.text = "购买价格：\(model.buyPrice)"
        buyPriceLab.textColor = .red
        buyPriceLab.font = UIFont.boldSystemFont(ofSize: 18)
        buyCountLab.text = "购买数量：\(model.buyCount)"
        buyCountLab.textColor = .red
        buyCountLab.font = UIFont.boldSystemFont(ofSize: 18)


        var dealStatusStr = ""
        if model.dealStatus == DealStatusType.underway.rawValue{
            dealStatusStr = "进行中"
            dealStatusLab.textColor = .red
            dealStatusLab.layer.borderColor = UIColor.red.cgColor
        }else if model.dealStatus == DealStatusType.finish.rawValue {
            dealStatusStr = "已结束"
            dealStatusLab.textColor = .gray
            dealStatusLab.layer.borderColor = UIColor.gray.cgColor
        }else if model.dealStatus == DealStatusType.plan.rawValue {
            dealStatusStr = "计划中"
            dealStatusLab.textColor = .green
            dealStatusLab.layer.borderColor = UIColor.green.cgColor
        }
        dealStatusLab.text = dealStatusStr
        dealStatusLab.font = UIFont.boldSystemFont(ofSize: 18)
        dealStatusLab.layer.borderWidth = 1
        dealStatusLab.layer.masksToBounds = true



        var dealTypeStr = ""
        if model.dealType == DealType.initialBuy.rawValue {
            dealTypeStr = "初始买"
            dealTypeLab.layer.borderColor = UIColor.red.cgColor
        }else if model.dealType == DealType.buy.rawValue {
            dealTypeStr = "买"
            dealTypeLab.layer.borderColor = UIColor.red.cgColor
        }else if model.dealType == DealType.sell.rawValue {
            dealTypeStr = "卖"
            dealTypeLab.layer.borderColor = UIColor.green.cgColor
        }
        dealTypeLab.text = dealTypeStr
        dealTypeLab.font = UIFont.boldSystemFont(ofSize: 18)
        dealTypeLab.layer.borderWidth = 1
        dealTypeLab.layer.masksToBounds = true


    }

}
