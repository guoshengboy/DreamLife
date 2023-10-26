//
//  FundAddViewController.swift
//  DreamLife
//
//  Created by 曹国盛 on 2023/10/26.
//

import Foundation
import UIKit

class FundAddViewController: BaseViewController {

    lazy var addBtn: UIBarButtonItem = UIBarButtonItem(title: "确定", style: .plain, target: self, action: #selector(addFundAction))

    lazy var nameLab: UILabel = UILabel().then {
        $0.text = "基金名称："
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textAlignment = .right
    }

    lazy var nameTF: UITextField = UITextField().then {
        $0.placeholder = "请输入基金名称"
        $0.borderStyle = .none
    }

    lazy var codeLab: UILabel = UILabel().then {
        $0.text = "基金代码："
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textAlignment = .right
    }

    lazy var codeTF: UITextField = UITextField().then {
        $0.placeholder = "请输入基金代码"
        $0.borderStyle = .none
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

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "添加基金"

        addSubViews()
        layout()
    }

    func addSubViews() {
        view.addSubview(nameLab)
        view.addSubview(nameTF)
        view.addSubview(codeLab)
        view.addSubview(codeTF)
        view.addSubview(dateLab)
        view.addSubview(dateBtn)
    }

    func layout() {
        let h = 40
        nameLab.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(kStatusNavHeight)
            make.left.equalToSuperview().offset(0)
            make.width.equalTo(100)
            make.height.equalTo(h)
        }

        nameTF.snp.makeConstraints { make in
            make.left.equalTo(nameLab.snp_rightMargin).offset(10)
            make.centerY.equalTo(nameLab)
        }

        codeLab.snp.makeConstraints { make in
            make.top.equalTo(nameLab.snp_bottomMargin).offset(10)
            make.left.equalTo(nameLab)
            make.width.height.equalTo(nameLab)
        }

        codeTF.snp.makeConstraints { make in
            make.left.equalTo(codeLab.snp_rightMargin).offset(10)
            make.centerY.equalTo(codeLab)
        }

        dateLab.snp.makeConstraints { make in
            make.top.equalTo(codeLab.snp_bottomMargin).offset(10)
            make.left.equalTo(nameLab)
            make.width.height.equalTo(nameLab)
        }

        dateBtn.snp.makeConstraints { make in
            make.left.equalTo(dateLab.snp_rightMargin).offset(10)
            make.centerY.equalTo(dateLab)
        }
    }

    @objc func addFundAction() {

    }

    @objc func addDateAction() {

    }
}


