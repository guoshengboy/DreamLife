//
//  FundAddViewController.swift
//  DreamLife
//
//  Created by 曹国盛 on 2023/10/26.
//

import Foundation
import UIKit

class FundAddViewController: UIViewController {

    lazy var addBtn: UIBarButtonItem = UIBarButtonItem(title: "确定", style: .plain, target: self, action: #selector(addFundAction))

    lazy var nameLab: UILabel = UILabel().then {
        $0.text = "基金名称："
        $0.font = UIFont.systemFont(ofSize: 16)
    }

    lazy var nameTF: UITextField = UITextField().then {
        $0.placeholder = "请输入基金名称"
        $0.borderStyle = .none
    }

    lazy var codeLab: UILabel = UILabel().then {
        $0.text = "基金代码："
        $0.font = UIFont.systemFont(ofSize: 16)
    }

    lazy var codeTF: UITextField = UITextField().then {
        $0.placeholder = "请输入基金代码"
        $0.borderStyle = .none
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "添加基金"
    }

    func addSubViews() {
        view.addSubview(nameLab)
        view.addSubview(nameTF)
        view.addSubview(codeLab)
        view.addSubview(codeTF)
    }

    func layout() {
        let h = 40
        nameLab.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(kStatusNavHeight)
            make.left.equalToSuperview().offset(0)
            make.width.equalTo(100)
            make.height.equalTo(h)
        }
    }

    @objc func addFundAction() {

    }
}


