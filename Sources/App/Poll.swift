//
//  Poll.swift
//  App
//

import Foundation
import Vapor

struct Poll: Content {
    var id: UUID?
    var title: String
    var option1: String
    var option2: String
    var votes1: Int
    var votes2: Int
}
