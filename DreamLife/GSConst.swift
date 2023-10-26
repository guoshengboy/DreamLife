//
//  GSConst.swift
//  PudongNews
//
//  Created by 曹国盛 on 2021/4/25.
//  Copyright © 2021 浦东电视台. All rights reserved.
//

import UIKit

let kScreenBounds = UIScreen.main.bounds
let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height
let kScaleWidth = kScreenWidth / 375.0
let kScaleHeight = kScreenHeight / 667.0

let kStatusHeight = UIApplication.shared.statusBarFrame.size.height
let kStatusNavHeight = kStatusHeight + 44
let kTabBarHeight: CGFloat = kStatusHeight > 20 ? 83 : 49
let kBottomBarHeight: CGFloat = kStatusHeight > 20 ? 34 :0
