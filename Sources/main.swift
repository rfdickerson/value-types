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

struct Body {
    var bytes: [UInt8]
    init(bytes: [UInt8]) {
        self.bytes = bytes
    }
}

struct Version {
  var major: Int
  var minor: Int
}

class ResponseA {

  var body: Body
  var headers = [String: String]()
  
  init(body: Body) {
    self.body = body
  }
  
}

struct ResponseB {
  var body: Body
  var headers: [String: String]
}

func handle(headers: [String: String]) -> [String: String] {
    var newHeaders = headers
    
    if newHeaders["myHeader"] != nil {
        newHeaders["myHeader"] = nil
    } else {
        newHeaders["myHeader"] = "myHeaderValue"
    }
    return newHeaders
}

func handle(_ response: ResponseA) {
    response.headers = handle(headers: response.headers)
}

func handle(_ response: ResponseB) -> ResponseB {
    let newHeaders = handle(headers: response.headers)
    return ResponseB(body: response.body, headers: newHeaders)
}


let payload = String(repeating: Character("~"), count: 5000000)

var a = ResponseA(body: Body(bytes: Array(payload.utf8)))
var b = ResponseB(body: Body(bytes: Array(payload.utf8)), headers: [String: String]())

for i in 0...100000 {
  b = handle(b)
}

//for i in 0...100000 {
//  handle(a)
//}
// print(b.body) 
