//
//  DealCell.swift
//  DreamLife
//
//  Created by 曹国盛 on 2023/11/6.
//

import Foundation
import UIKit

protocol DealCellHandleProtocol {
    
}

class DealCell: UITableViewCell {

    //MARK: DealCell
    
    @IBOutlet weak var TVTitleLab: UILabel!
    @IBOutlet weak var TVValueLab: UILabel!

    func setupCellWithTV(title: String, value: String) {
        TVTitleLab.text = title
        TVValueLab.text = value
    }

    //MARK: DealCellTF

    @IBOutlet weak var TFTitleLab: UILabel!
    @IBOutlet weak var TFTextFiled: UITextField!

    func setupCellWithTF(title: String, placeholder: String, tfText: String = "") {
        TFTitleLab.text = title
        TFTextFiled.text = tfText
        TFTextFiled.placeholder = placeholder
    }

    //MARK: DealCellTC

    @IBOutlet weak var TCTitleLab: UILabel!
    @IBOutlet weak var TCTextField: UITextField!
    @IBOutlet weak var TCResultLab: UILabel!


    //MARK: DealCellTB
    @IBOutlet weak var TBTitleLab: UILabel!
    @IBOutlet weak var TBBtn: UIButton!


    func setupCell(model: DealCellModel)  {
        if model.cellType == "TV" {
            TVTitleLab.text = model.title
            TVValueLab.text = model.value
        }else if model.cellType == "TF" {

        }

    }
}
