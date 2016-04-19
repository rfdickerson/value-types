//
//  Response.swift
//  valuetypes
//
//  Created by Robert Dickerson on 4/19/16.
//
//

import Foundation

protocol Response {
    
    var body:Body {get set}
    var headers:[String:String] {get set}
    
}