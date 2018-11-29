//
//  DataControllerProtocol.swift
//  BrokenSDU
//
//  Created by Emil Frisk on 28/11/2018.
//  Copyright © 2018 SDU. All rights reserved.
//

import Foundation

protocol DataControllerProtocol {
    func createReport(description: String,
                      image: Data,
                      room: String,
                      timestamp: Date,
                      title: String,
                      userId: String) -> Report
    func saveReport(report: Report)
    func loadReports(userId: String, completion: @escaping (Report) -> ())
}
