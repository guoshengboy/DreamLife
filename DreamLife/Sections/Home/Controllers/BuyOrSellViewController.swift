//
//  BuyOrSellViewController.swift
//  DreamLife
//
//  Created by 曹国盛 on 2023/10/30.
//

import Foundation

import UIKit
import DatePickerDialog
import Toaster


class BuyOrSellViewController: BaseViewController {

    var baseModel: FundDealModel?
    var dealType: DealType = .sell
    var detalStatus: DealStatusType = .plan
    var dealStr: String? {
        get{
            return dealType == .sell ? "卖出" : "购买"
        }
    }

    lazy var addBtn: UIBarButtonItem = UIBarButtonItem(title: "确定", style: .plain, target: self, action: #selector(addFundAction))

    lazy var nameLab: UILabel = UILabel().then {
        $0.text = "基金名称："
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textAlignment = .right
    }

    lazy var nameValueLab: UILabel = UILabel().then {
        $0.text = baseModel?.fundName ?? ""
        $0.font = UIFont.systemFont(ofSize: 16)
    }

    lazy var codeLab: UILabel = UILabel().then {
        $0.text = "基金代码："
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textAlignment = .right
    }

    lazy var codeValueLab: UILabel = UILabel().then {
        $0.text = baseModel?.fundCode ?? ""
        $0.font = UIFont.systemFont(ofSize: 16)
    }

    lazy var fatherPriceLab: UILabel = UILabel().then {
        $0.text = "初始买价格："
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textAlignment = .right
    }

    lazy var  fatherPriceValueLab: UILabel = UILabel().then {
        $0.text = baseModel?.buyPrice ?? ""
        $0.font = UIFont.systemFont(ofSize: 16)
    }

    lazy var dateLab: UILabel = UILabel().then {
        $0.text = "添加日期："
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textAlignment = .right
    }

    lazy var dateBtn: UIButton = UIButton().then {
        $0.setTitle("点击添加日期", for: .normal)
        $0.addTarget(self, action: #selector(addDateAction), for: .touchUpInside)
        $0.setTitleColor(.blue, for: .normal)
    }

    lazy var buyPriceLab: UILabel = UILabel().then {
        $0.text = "\(dealStr!)价格："
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textAlignment = .right
    }

    lazy var buyPriceTF: UITextField = UITextField().then {
        $0.placeholder = "请输入\(dealStr!)价格"
    }

    lazy var buyCountLab: UILabel = UILabel().then {
        $0.text = "\(dealStr!)数量："
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textAlignment = .right
    }

    lazy var buyCountTF: UITextField = UITextField().then {
        $0.placeholder = "请输入\(dealStr!)数量"
    }

    lazy var dealStatusLab: UILabel = UILabel().then {
        $0.text = "交易状态："
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textAlignment = .right
    }

    lazy var dealStatusBtn: UIButton = UIButton().then {
        $0.setTitle("点击选择交易状态", for: .normal)
        $0.addTarget(self, action: #selector(selectDealStatusAction), for: .touchUpInside)
        $0.setTitleColor(.blue, for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = dealStr!
        addSubViews()
        layout()
    }

    func addSubViews() {
        self.navigationItem.rightBarButtonItem = addBtn
        view.addSubview(nameLab)
        view.addSubview(nameValueLab)
        view.addSubview(codeLab)
        view.addSubview(codeValueLab)
        view.addSubview(fatherPriceLab)
        view.addSubview(fatherPriceValueLab)
        view.addSubview(dateLab)
        view.addSubview(dateBtn)
        view.addSubview(buyPriceLab)
        view.addSubview(buyPriceTF)
        view.addSubview(buyCountLab)
        view.addSubview(buyCountTF)
        view.addSubview(dealStatusLab)
        view.addSubview(dealStatusBtn)
    }

    func layout() {
        let h = 40
        nameLab.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(kStatusNavHeight)
            make.left.equalToSuperview().offset(0)
            make.width.equalTo(100)
            make.height.equalTo(h)
        }

        nameValueLab.snp.makeConstraints { make in
            make.left.equalTo(nameLab.snp_rightMargin).offset(10)
            make.centerY.equalTo(nameLab)
        }

        codeLab.snp.makeConstraints { make in
            make.top.equalTo(nameLab.snp_bottomMargin).offset(10)
            make.left.equalTo(nameLab)
            make.width.height.equalTo(nameLab)
        }

        codeValueLab.snp.makeConstraints { make in
            make.left.equalTo(codeLab.snp_rightMargin).offset(10)
            make.centerY.equalTo(codeLab)
        }

        fatherPriceLab.snp.makeConstraints { make in
            make.top.equalTo(codeLab.snp_bottomMargin).offset(10)
            make.left.equalTo(codeLab)
            make.width.height.equalTo(codeLab)
        }

        fatherPriceValueLab.snp.makeConstraints { make in
            make.left.equalTo(fatherPriceLab.snp_rightMargin).offset(10)
            make.centerY.equalTo(fatherPriceLab)
        }

        dateLab.snp.makeConstraints { make in
            make.top.equalTo(fatherPriceLab.snp_bottomMargin).offset(10)
            make.left.equalTo(fatherPriceLab)
            make.width.height.equalTo(fatherPriceLab)
        }

        dateBtn.snp.makeConstraints { make in
            make.left.equalTo(dateLab.snp_rightMargin).offset(10)
            make.centerY.equalTo(dateLab)
        }

        buyPriceLab.snp.makeConstraints { make in
            make.top.equalTo(dateLab.snp_bottomMargin).offset(10)
            make.left.equalTo(dateLab)
            make.width.height.equalTo(dateLab)
        }

        buyPriceTF.snp.makeConstraints { make in
            make.left.equalTo(buyPriceLab.snp_rightMargin).offset(10)
            make.centerY.equalTo(buyPriceLab)
        }

        buyCountLab.snp.makeConstraints { make in
            make.top.equalTo(buyPriceLab.snp_bottomMargin).offset(10)
            make.left.equalTo(buyPriceLab)
            make.width.height.equalTo(buyPriceLab)
        }

        buyCountTF.snp.makeConstraints { make in
            make.left.equalTo(buyCountLab.snp_rightMargin).offset(10)
            make.centerY.equalTo(buyCountLab)
        }

        dealStatusLab.snp.makeConstraints { make in
            make.top.equalTo(buyCountLab.snp_bottomMargin).offset(10)
            make.left.equalTo(buyCountLab)
            make.width.height.equalTo(buyCountLab)
        }

        dealStatusBtn.snp.makeConstraints { make in
            make.left.equalTo(dealStatusLab.snp_rightMargin).offset(10)
            make.centerY.equalTo(dealStatusLab)
        }
    }

    @objc func addFundAction() {

        if dealStatusBtn.title(for: .normal) == "点击选择交易状态" {
            GSTool.show(text: "请选择交易状态")
            return
        }

        var dateString = "无"
        if dateBtn.title(for: .normal) == "点击添加日期" && !dealStatusBtn.title(for: .normal)!.contains("计划") {
            GSTool.show(text: "请选择购买日期")
            return
        }


        if buyPriceTF.text?.count == 0 {
            GSTool.show(text: "请输入\(dealStr!)价格")
            return
        }

        if buyCountTF.text?.count == 0 {
            GSTool.show(text: "请输入\(dealStr!)数量")
            return
        }

        var dealStatus = DealStatusType.underway
        if dealStatusBtn.title(for: .normal)!.contains("1"){
            dealStatus = .underway
            dateString = dateBtn.title(for: .normal)!
        }
        if dealStatusBtn.title(for: .normal)!.contains("2"){
            dealStatus = .finish
            dateString = dateBtn.title(for: .normal)!
        }
        if dealStatusBtn.title(for: .normal)!.contains("3"){
            dealStatus = .plan
            dateString = "无"
        }

        let dealModel = FundDealModel()
        dealModel.fundName = baseModel?.fundName ?? ""
        dealModel.fundCode = baseModel?.fundCode ?? ""
        dealModel.fatherID = baseModel?.dealID ?? ""
        dealModel.dealID = GSTool.getTimeStamp()
        dealModel.dealType = dealType.rawValue
        dealModel.dealStatus = dealStatus.rawValue
        dealModel.addDate = dateString
        if dealType == .buy {
            dealModel.buyPrice = buyPriceTF.text ?? ""
            dealModel.buyCount = buyCountTF.text ?? ""
        }else{
            dealModel.sellPrice = buyPriceTF.text ?? ""
            dealModel.sellCount = buyCountTF.text ?? ""
        }

        DBManager.shareManager.insert(object: dealModel)
        navigationController?.popViewController(animated: true)
    }

    //选择交易状态
    @objc func selectDealStatusAction() {
        GSTool.showSheet(title: "请选择交易状态" ,titleArray: [ "3：计划中", "2：已结束"], currentVC: self) { title in
            self.dealStatusBtn.setTitle(title, for: .normal)
        }
    }

    //选择日期
    @objc func addDateAction() {
        DatePickerDialog().show("请选择日期") {  date in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "YYYY-MM-dd"
                self.dateBtn.setTitle(formatter.string(from: dt), for: .normal)
            }
        }
    }
}
