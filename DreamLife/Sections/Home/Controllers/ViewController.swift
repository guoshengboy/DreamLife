//
//  ViewController.swift
//  DreamLife
//
//  Created by 曹国盛 on 2023/10/26.
//

import UIKit
import Then
import SnapKit

class ViewController: BaseViewController {

    lazy var tableView: UITableView = UITableView(frame: CGRect.zero, style: .plain).then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(HomeFundCell.self, forCellReuseIdentifier: "HomeFundCell")
    }

    lazy var addBtn: UIBarButtonItem = UIBarButtonItem(title: "添加", style: .plain, target: self, action: #selector(addFundAction))

    var fundArray: [FundModel] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的基金"
        print(NSHomeDirectory())
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
        fundArray = DBManager.shareManager.getAllObjects(cls: FundModel.self)
        self.tableView.reloadData()
    }

    @objc func addFundAction() {
        let vc = FundAddViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fundArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeFundCell", for: indexPath) as? HomeFundCell else {return UITableViewCell()}
        cell.setupCell(model: fundArray[indexPath.row])
        return cell
    }
}

