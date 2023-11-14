//
//  DealCell.swift
//  DreamLife
//
//  Created by 曹国盛 on 2023/11/6.
//

import Foundation
import UIKit

protocol DealCellHandleProtocol {
    func clickBtn(btn: UIButton, model: DealCellModel)
}

class DealCell: UITableViewCell {

    var delegate: DealCellHandleProtocol?
    var currentModel: DealCellModel?

    //MARK: DealCell
    
    @IBOutlet weak var TVTitleLab: UILabel!
    @IBOutlet weak var TVValueLab: UILabel!

    //MARK: DealCellTF

    @IBOutlet weak var TFTitleLab: UILabel!
    @IBOutlet weak var TFTextFiled: UITextField!


    //MARK: DealCellTC

    @IBOutlet weak var TCTitleLab: UILabel!
    @IBOutlet weak var TCTextField: UITextField!
    @IBOutlet weak var TCResultLab: UILabel!


    //MARK: DealCellTB
    @IBOutlet weak var TBTitleLab: UILabel!
    @IBOutlet weak var TBBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        if self.TVTitleLab != nil{
            self.TVTitleLab.adjustsFontSizeToFitWidth = true
            self.TVTitleLab.minimumScaleFactor = 0.5
        }

        if self.TFTitleLab != nil{
            self.TFTitleLab.adjustsFontSizeToFitWidth = true
            self.TFTitleLab.minimumScaleFactor = 0.5
        }

        if self.TBTitleLab != nil{
            self.TBTitleLab.adjustsFontSizeToFitWidth = true
            self.TBTitleLab.minimumScaleFactor = 0.5
        }

        if self.TCTitleLab != nil{
            self.TCTitleLab.adjustsFontSizeToFitWidth = true
            self.TCTitleLab.minimumScaleFactor = 0.5
        }
    }

    @IBAction func TBClickBtn(_ sender: Any) {
        delegate?.clickBtn(btn: TBBtn, model: currentModel!)
    }

    func setupCell(model: DealCellModel)  {
        currentModel = model
        if model.cellType == "TV" {
            TVTitleLab.text = model.title
            TVValueLab.text = model.value
        }else if model.cellType == "TF" {
            TFTitleLab.text = model.title
            TFTextFiled.text = model.value
            TFTextFiled.placeholder = model.placeholder
            TFTextFiled.keyboardType = model.keyboardType
        }else if model.cellType == "TB" {
            TBTitleLab.text = model.title
            TBBtn.setTitle(model.value, for: .normal)
        }else if model.cellType == "TC" {
            TCTitleLab.text = model.title
            TCTextField.text = model.value
            TCTextField.placeholder = model.placeholder
            TCTextField.keyboardType = model.keyboardType
            TCResultLab.text = model.value2
        }

    }
}
