//
//  DealViewController.swift
//  DreamLife
//
//  Created by 曹国盛 on 2023/11/6.
//

import Foundation
import Then
import SnapKit

enum DealAddType {
    case add
    case edit
}

class DealViewController: BaseViewController {

    var model: FundDealModel?
    var baseMolde: FundModel?
    var addType: DealAddType = .add
    var dealType: DealType = .initialBuy 
    var pageTitle: String {
        get {
            if dealType == .initialBuy {
                return "初始买"
            }else if dealType == .buy {
                return "买入"
            }else{
                return "卖出"
            }
        }
    }
    var lastModel: FundDealModel?
    var date: String = ""
    var price: Double = 0
    var count: Int = 0

    var titleArray: [[String:String]] = []

    lazy var tableView: UITableView = UITableView(frame: CGRect.zero, style: .plain).then {
        $0.delegate = self
        $0.dataSource = self
    }

    lazy var addBtn: UIBarButtonItem = UIBarButtonItem(title: "添加", style: .plain, target: self, action: #selector(addFundAction))

    override func viewDidLoad() {
        super.viewDidLoad()
        title = pageTitle
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

        //添加
        if addType == .add{
            model = FundDealModel()
            model?.fundName = baseMolde?.fundName ?? ""
            model?.fundCode = baseMolde?.fundCode ?? ""
            model?.dealType = dealType.rawValue

            if dealType == .initialBuy {
                lastModel = FundDealModel.getInitialBuyOfLowestPrice(code: baseMolde?.fundCode ?? "")
            }
        }

//        if dealType == .initialBuy || dealType == .buy {
//            return [["title": "基金名称", "cell": "TV", "value": ""],
//                    ["title": "交易状态", "cell": "TB", "value": ""],
//                    ["title": "买入日期", "cell": "TB", "value": ""],
//                    ["title": "买入价格", "cell": "TC", "value": ""],
//                    ["title": "买入数量", "cell": "TF", "value": ""]]
//        }else {
//            return  [["title": "基金名称", "cell": "TV", "value": ""],
//                     ["title": "交易状态", "cell": "TB", "value": ""],
//                     ["title": "卖出日期", "cell": "TB", "value": ""],
//                     ["title": "卖出价格", "cell": "TC", "value": ""],
//                     ["title": "卖出数量", "cell": "TF", "value": ""]]
//        }

        tableView.reloadData()
    }

    @objc func addFundAction() {

    }

}

extension DealViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dic = self.titleArray[indexPath.row]
        if dic["cell"] == "TV" {
            guard let cell = Bundle.main.loadNibNamed("DealCell", owner: nil)?[0] as? DealCell else {return UITableViewCell()}
            cell.selectionStyle = .none
            return cell
        }else if dic["cell"] == "TF" {
            guard let cell = Bundle.main.loadNibNamed("DealCell", owner: nil)?[1] as? DealCell else {return UITableViewCell()}
            cell.selectionStyle = .none
            return cell
        }else if dic["cell"] == "TB" {
            guard let cell = Bundle.main.loadNibNamed("DealCell", owner: nil)?[2] as? DealCell else {return UITableViewCell()}
            cell.selectionStyle = .none
            return cell
        }else if dic["cell"] == "TC" {
            guard let cell = Bundle.main.loadNibNamed("DealCell", owner: nil)?[3] as? DealCell else {return UITableViewCell()}
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

