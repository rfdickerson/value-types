//
//  ResponseStruct.swift
//  valuetypes
//
//  Created by Robert Dickerson on 4/19/16.
//
//

import Foundation

struct ResponseB: Response {
    
    var body: Body
    var headers = [String:String]()
    
}