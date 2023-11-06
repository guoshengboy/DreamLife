//
//  GSTool.swift
//  DreamLife
//
//  Created by 曹国盛 on 2023/10/27.
//

import Foundation
import Toaster
import DatePickerDialog

struct GSTool {
    ///需要传对象
    static func classNameAsString(obj: Any) -> String {
        return String(describing: type(of: obj))
    }

    static func show(text: String) {
        //toast设置
        ToastView.appearance().font = UIFont.systemFont(ofSize: 18)
        ToastView.appearance().bottomOffsetPortrait = 550
        Toast(text: text).show()
    }

    static func showSheet(title: String = "", titleArray: [String], currentVC: UIViewController, clickBlock:@escaping (String)->()) {
        let alertCtrl = UIAlertController(title: title, message: "", preferredStyle: .actionSheet)
        for title in titleArray {
            let action = UIAlertAction(title: title, style: .default) { (action:UIAlertAction!) in
                clickBlock(title)
            }
            alertCtrl.addAction(action)
        }

        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        alertCtrl.addAction(cancelAction)

        currentVC.present(alertCtrl, animated: true)
    }

    ///选择交易状态
    static func showDealStatus(currentVC: UIViewController, clickBlock:@escaping (String, DealStatusType)->()) {
        showSheet(title: "请选择交易状态" ,titleArray: ["进行中", "已结束", "计划中"], currentVC: currentVC) { title in
            if title == "进行中" {
                clickBlock(title, .underway)
            }else if title == "已结束"{
                clickBlock(title, .finish)
            }else if title == "计划中"{
                clickBlock(title, .plan)
            }
        }
    }

    static func showDate(selectDateBlock:@escaping (String)->()) {
        DatePickerDialog().show("请选择日期") {  date in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "YYYY-MM-dd"
                let dateString = formatter.string(from: dt)
                selectDateBlock(dateString)
            }
        }
    }

    static func getTimeStamp() -> String {
        let date = Date()
        let currentTimeInterval = date.timeIntervalSince1970
        return String(currentTimeInterval)
    }


}
