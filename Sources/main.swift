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


/**
 This method mutates Response in place
 */
func appendData(response: ResponseClass) {
    
    switch response.body {
        case .plainText(let text):
            let newtext = text + "Additional information"
            response.body = .plainText(newtext)
        default:
            print("Unknown response type")
    }
    
}

func appendData(response: ResponseStruct ) -> ResponseStruct {
    
    switch response.body {
    case .plainText(let text):
        let newtext = text + "Additional information"
        
        let newResponse = ResponseStruct(body: .plainText(newtext),
                                    headers: response.headers )
        return newResponse
    default:
        print("Unknown response type")
        return ResponseStruct(body: .Nothing, headers: response.headers)
    }
    
}

func changeHeaders(response: ResponseClass) {
    response.headers["OAuth"] = "token here"

}

func changeHeaders(response: ResponseStruct) -> ResponseStruct {
    var newHeaders = response.headers
    newHeaders["OAuth"] = "token here"
    return ResponseStruct(body: response.body, headers: newHeaders)
}

/// Experiment goes here
var E1 = [Double]()
var E2 = [Double]()
var E3 = [Double]()
var E4 = [Double]()

for i in 1...2000 {
    
    let iterations = 100
    let size = 500*i
    
    let payload = String(repeating: Character("~"), count: size)
    
    var a = ResponseClass(body: .plainText(payload))
    var b = ResponseStruct(body: .plainText(payload), headers: Headers())
    
    let classTime = benchmark( {
        appendData(a)
    })
    
    let structTime = benchmark( {
        appendData(b)
    })
    
    let classHeaderTime = benchmark( {
        changeHeaders(a)
    })
    
    let structHeaderTime = benchmark( {
        changeHeaders(b)
    })
    
    E1.append(classTime.0)
    E2.append(structTime.0)
    E3.append(classHeaderTime.0)
    E4.append(structHeaderTime.0)
}


print(E1)
print(E2)
print(E3)
print(E4)
