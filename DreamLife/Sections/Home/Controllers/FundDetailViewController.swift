//
//  FundDetailViewController.swift
//  DreamLife
//
//  Created by 曹国盛 on 2023/10/30.
//

import Foundation
import Then
import SnapKit

class FundDetailViewController: BaseViewController {

    var model: FundModel?

    lazy var tableView: UITableView = UITableView(frame: CGRect.zero, style: .plain).then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "FundDetailCell")
    }

    lazy var titleArray = ["基金配置", "全部", "进行中", "已结束"]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = model?.fundName
        addSubViews()
        layout()
    }

    func addSubViews() {
        view.addSubview(tableView)
    }

    func layout() {
        tableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview().offset(0)
        }
    }
}

extension FundDetailViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let title = titleArray[indexPath.row]
        if title == "全部" || title == "进行中" || title == "已结束"{
            let vc = FundDealViewController()
            vc.dealSearchType = title
            vc.model = model
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FundDetailCell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = titleArray[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
