/**
 * Copyright IBM Corporation 2015
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/
 
import Foundation



//
//  Experiment.swift
//  valuetypes
//
//  Created by Robert Dickerson on 4/19/16.
//
//

import Foundation

/**
 This method mutates Response in place
 */
func handle(response: ResponseClass) {
    
    response.headers["OAuth"] = "token here"
    
    switch response.body {
    case .plainText(let text):
        let newtext = text + "Additional information"
        
        response.body = .plainText(newtext)
    default:
        print("Unknown response type")
        return
    }
    
}

func handle(response: ResponseStruct ) -> ResponseStruct {
    
    
    var newheaders = response.headers
    newheaders["OAuth"] = "token here"
    
    switch response.body {
    case .plainText(let text):
        let newtext = text + "Additional information"
        
        
        let newResponse = ResponseStruct(body: .plainText(newtext),
                                    headers: newheaders )
        return newResponse
    default:
        print("Unknown response type")
        return ResponseStruct(body: .Nothing, headers: response.headers)
    }
    
}


/// Experiment goes here
var structureTimes = [Double]()
var classTimes = [Double]()

for i in 1...200 {
    
    let iterations = 100
    let size = 500*i
    
    let payload = String(repeating: Character("~"), count: size)
    
    var a = ResponseClass(body: .plainText(payload))
    var b = ResponseStruct(body: .plainText(payload), headers: Headers())
    
    let classTime = benchmark( {
        for _ in 0...iterations {
            handle(a)
        }
    })
    
    let structTime = benchmark( {
        for _ in 0...iterations {
            handle(b)
        }
    })
    
    classTimes.append(classTime)
    structureTimes.append(structTime)
    
}


print(structureTimes)

print(classTimes)
