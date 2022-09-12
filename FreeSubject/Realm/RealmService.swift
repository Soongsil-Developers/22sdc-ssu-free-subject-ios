//
//  RealmService.swift
//  FreeSubject
//
//  Created by qualson1 on 2022/09/12.
//

import Foundation
import RealmSwift
import Realm

protocol RealmServiceType {
    
    func add(item: Day)
    func update(item: Day, newTask: Day)
//    func fetch(type: MemoType) -> [Memo]
}

final class RealmService: RealmServiceType {
    
    static let shared = RealmService()
    let localRealm = try! Realm()
    
    func add(item: Day) {
        
        try! localRealm.write {
            localRealm.add(item)
        }
    }
    
    func update(item: Day, newTask: Day) {
        try! localRealm.write {
            localRealm.create(
                Day.self,
                value: ["_id": item._id,
                        "createdDate": newTask.createdDate,
                        "iconFeeling" : newTask.iconFeeling,
                        "didFeelingChange": newTask.didFeelingChange,
                        "didTakeMedicine": newTask.didTakeMedicine,
                        "firstQuestion": newTask.firstQuestion,
                        "secondQuestion": newTask.secondQuestion,
                        "thirdQuestion": newTask.thirdQuestion
                       ]
            )
        }
    }
    
    init() {
        print("Realm Location: ", localRealm.configuration.fileURL ?? "cannot find locaation.")
        
    }
}

