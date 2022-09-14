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
    @Persisted var createdDate: String
    @Persisted var iconFeeling: String
    @Persisted var sleepTime: String
    @Persisted var didFeelingChange: Bool
    @Persisted var didTakeMedicine: Bool
    @Persisted var firstQuestion: String
    @Persisted var secondQuestion: String
    @Persisted var thirdQuestion: String // 질문지에서 마지막 표에 대한 데이터
    
    @Persisted(primaryKey: true) var _id: ObjectId // primaryKey
    
    override static func primaryKey() -> String? {
      return "Date"
    }

    convenience init(createdDate:String,iconFeeling:String, sleepTime:String,didFeelingChange:Bool,didTakeMedicine:Bool,firstQuestion:String, secondQuestion:String, thirdQuestion:String) {
        self.init()
        self.createdDate = createdDate
        self.iconFeeling = iconFeeling
        self.sleepTime = sleepTime
        self.didFeelingChange = didFeelingChange
        self.didTakeMedicine = didTakeMedicine
        self.firstQuestion = firstQuestion
        self.secondQuestion = secondQuestion
        self.thirdQuestion = thirdQuestion
    }
}
