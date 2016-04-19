//
//  ResponseClass.swift
//  valuetypes
//
//  Created by Robert Dickerson on 4/19/16.
//
//

import Foundation

final class ResponseA: Response {
    
    var body: Body
    var headers = [String:String]()
    
    init(body: Body) {
        self.body = body
    }
    
}