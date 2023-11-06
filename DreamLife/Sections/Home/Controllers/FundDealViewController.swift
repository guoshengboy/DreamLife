//
//  FundDealViewController.swift
//  DreamLife
//
//  Created by 曹国盛 on 2023/10/30.
//

import Foundation

import Then
import SnapKit
import WCDBSwift

class FundDealViewController: BaseViewController {

    var dealSearchType:String = ""
    var model: FundModel?

    lazy var tableView: UITableView = UITableView(frame: CGRect.zero, style: .plain).then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(UINib(nibName: "DealInitialBuyCell", bundle: nil), forCellReuseIdentifier: "DealInitialBuyCell")
    }

    lazy var addBtn: UIBarButtonItem = UIBarButtonItem(title: "添加初始交易", style: .plain, target: self, action: #selector(addInitBuyAction))

    var dealArray: [[FundDealModel]] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = dealSearchType
        addSubViews()
        layout()
        updateData()
    }

    func addSubViews() {
        self.navigationItem.rightBarButtonItem = addBtn
        view.addSubview(tableView)
    }

    func layout() {
        tableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview().offset(0)
        }
    }

    func updateData() {
        //先获取初始买的数据(进行中或者计划中的)
        let initBuyArray = DBManager.shareManager.getObjects(cls: FundDealModel.self, where: FundDealModel.Properties.fundCode == model?.fundCode ?? "" && FundDealModel.Properties.dealType == DealType.initialBuy.rawValue && (FundDealModel.Properties.dealStatus == DealStatusType.underway.rawValue || FundDealModel.Properties.dealStatus == DealStatusType.plan.rawValue))

        //从低到高排序
        let sortArray = initBuyArray.sorted { model1, model2 in
            return (Double(model1.buyPrice) ?? 0) < (Double(model2.buyPrice) ?? 0)
        }
        dealArray.removeAll()
        for item in sortArray {
            var resultArray: [FundDealModel] = []
            resultArray.append(item)
            let subArray = FundDealModel.getSubarray(model: item)
            resultArray.append(contentsOf: subArray)
            dealArray.append(resultArray)
        }
        tableView.reloadData()
    }

    @objc func addInitBuyAction() {
        let vc = DealViewController()
        vc.dealType = .initialBuy
        navigationController?.pushViewController(vc, animated: true)
    }

    //删除交易记录
    func deleteFund(model: FundDealModel) {
        //只能删除计划中的数据
        if model.dealStatus != DealStatusType.plan.rawValue {
            GSTool.show(text: "只能删除计划中的数据")
            return
        }
        
        //为初始买 则要删除所有相关的唯一标识的数据
        if model.dealType == DealType.initialBuy.rawValue {
            DBManager.shareManager.deleteObject(tableName: "FundDealModel", where: FundDealModel.Properties.dealID == model.dealID || FundDealModel.Properties.fatherID == model.dealID)
        }else{//直接删除当前数据即可
            DBManager.shareManager.deleteObject(tableName: "FundDealModel", where: FundDealModel.Properties.dealID == model.dealID)
        }
        updateData()
    }

    //买和卖
    func buyOrSell(model: FundDealModel, type: DealType) {
        let vc = BuyOrSellViewController()
        vc.dealType = type
        vc.baseModel = model
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension FundDealViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dealArray[section].count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return dealArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DealInitialBuyCell", for: indexPath) as? DealInitialBuyCell else {
            return UITableViewCell()
        }
        let array = dealArray[indexPath.section]
        cell.setupCell(initialBuy: array[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let model = dealArray[indexPath.section][indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "删除") { (action, view, handler) in
            self.deleteFund(model: model)
        }
        deleteAction.backgroundColor = .blue

        let buyAction = UIContextualAction(style: .destructive, title: "买") {[weak self] (action, view, handler) in
            guard let self = self else { return }
            self.buyOrSell(model: model, type: .buy)
        }
        buyAction.backgroundColor = .red

        let sellAction = UIContextualAction(style: .destructive, title: "卖") { (action, view, handler) in
            self.buyOrSell(model: model, type: .sell)
        }
        sellAction.backgroundColor = .green

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, buyAction, sellAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}

