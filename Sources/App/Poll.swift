//
//  Poll.swift
//  App
//

import Foundation
import Vapor
import Fluent
import FluentSQLite

struct Poll: Content, SQLiteUUIDModel {
    var id: UUID?
    var title: String
    var option1: String
    var option2: String
    var votes1: Int
    var votes2: Int
}

extension Poll: Migration { }
