//
//  Report.swift
//  BrokenSDU
//
//  Created by Emil Frisk on 28/11/2018.
//  Copyright © 2018 SDU. All rights reserved.
//

import Foundation

extension Report {
    func toDict() -> [String: String] {
        let dateFormatter = DateFormatter()
        return ["description": description_!,
                "room": room!,
                "timestamp": dateFormatter.string(from: timestamp!),
                "title": title!,
                "userId": userId!]
    }
}
