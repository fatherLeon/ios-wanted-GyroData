//
//  GyroInfo+CoreDataProperties.swift
//  GyroData
//
//  Created by 강민수 on 2023/06/15.
//
//

import Foundation
import CoreData


extension GyroInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GyroInfo> {
        return NSFetchRequest<GyroInfo>(entityName: "GyroInfo")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var url: URL?

}

extension GyroInfo : Identifiable {

}
