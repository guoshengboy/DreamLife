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

    var model: FundDealModel? //编辑会传过来、否则自己创建用于添加
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

    var dealCellModelList: [DealCellModel] = []

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

        getInitBuyData()
    }

    //初始买数据
    func getInitBuyData() {
        if (addType == .add){

            let lowPriceModel =  FundDealModel.getInitialBuyOfLowestPrice(code: baseMolde?.fundCode ?? "")
            dealCellModelList.append(DealCellModel.getModelWithTV(title: "基金名称：", value: baseMolde?.fundName ?? ""))
            dealCellModelList.append(DealCellModel.getModelWithTB(title: "购买状态：", value: "请选择当前状态"))
            dealCellModelList.append(DealCellModel.getModelWithTB(title: "购买日期：", value: "请选择日期"))
            dealCellModelList.append(DealCellModel.getModelWithTV(title: "参考价格公式：", value: (lowPriceModel?.calculateFormula.count == 0 ? "无" : lowPriceModel?.calculateFormula) ?? ""))
            dealCellModelList.append(DealCellModel.getModelWithTC(title: "购买价格：", value: "", value2: "0.0", placeholder: "请输入价格比例"))
            dealCellModelList.append(DealCellModel.getModelWithTF(title: "购买数量", value: "", placeholder: "请输入购买数量", keyboardType: .numberPad))

        }

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
        return dealCellModelList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dealCellModelList[indexPath.row]
        if model.cellType == "TV" {
            guard let cell = Bundle.main.loadNibNamed("DealCell", owner: nil)?[0] as? DealCell else {return UITableViewCell()}
            cell.selectionStyle = .none
            cell.setupCell(model: model)
            return cell
        }else if model.cellType == "TF" {
            guard let cell = Bundle.main.loadNibNamed("DealCell", owner: nil)?[1] as? DealCell else {return UITableViewCell()}
            cell.selectionStyle = .none
            cell.setupCell(model: model)
            return cell
        }else if model.cellType == "TB" {
            guard let cell = Bundle.main.loadNibNamed("DealCell", owner: nil)?[2] as? DealCell else {return UITableViewCell()}
            cell.selectionStyle = .none
            cell.setupCell(model: model)
            return cell
        }else if model.cellType == "TC" {
            guard let cell = Bundle.main.loadNibNamed("DealCell", owner: nil)?[3] as? DealCell else {return UITableViewCell()}
            cell.selectionStyle = .none
            cell.setupCell(model: model)
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

