//
//  Day.swift
//  FreeSubject
//
//  Created by 홍준혁 on 2022/09/06.
//

import RealmSwift
import Foundation
import UIKit

class Day: Object{
    @Persisted var Date: String = ""
    @Persisted var iconFeeling: String = ""
    @Persisted var sleepTime: String = ""
    @Persisted var didFeelingChange: Bool = true
    @Persisted var didTakeMedicine: Bool = true
    @Persisted var tableNum: Int = 0 // 질문지에서 마지막 표에 대한 데이터
    
    override static func primaryKey() -> String? {
      return "Date"
    }

    convenience init(Date:String,iconFeeling:String,sleepTime:String,didFeelingChange:Bool,didTakeMedicine:Bool,tableNum:Int) {
        self.init()
        self.Date = Date
        self.iconFeeling = iconFeeling
        self.sleepTime = sleepTime
        self.didFeelingChange = didFeelingChange
        self.didTakeMedicine = didTakeMedicine
        self.tableNum = tableNum
    }
}
