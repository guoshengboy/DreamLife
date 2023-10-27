//
//  HomeFundCell.swift
//  DreamLife
//
//  Created by 曹国盛 on 2023/10/26.
//

import Foundation
import UIKit

class HomeFundCell: UITableViewCell{

    var titleLab = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16)
    }

    var codeLab = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 9)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        layout()
    }

    func addSubViews() {
        contentView.addSubview(titleLab)
        contentView.addSubview(codeLab)
    }

    func layout() {
        titleLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview().offset(-5)
        }

        codeLab.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.top.equalTo(titleLab.snp_bottomMargin).offset(2)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setupCell(model: FundModel) {
        titleLab.text = model.fundName
        codeLab.text = model.fundCode
    }
}
