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
        let initBuyArray = DBManager.shareManager.getObjects(cls: FundDealModel.self, where: FundDealModel.Properties.fundCode == model?.fundCode ?? "" && FundDealModel.Properties.dealType == DealType.initialBuy.rawValue && FundDealModel.Properties.dealStatus == DealStatusType.underway.rawValue || FundDealModel.Properties.dealStatus == DealStatusType.plan.rawValue)
        dealArray.removeAll()
        for item in initBuyArray {
            dealArray.append([item])
        }
        tableView.reloadData()
    }

    @objc func addInitBuyAction() {
        let vc = InitialBuyViewController()
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
        let dealModel = dealArray[indexPath.section][indexPath.row]
//        if dealModel
        return true
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "删除") { (action, view, handler) in
        print("delete")
        }

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}

