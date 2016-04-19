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
func handle(response: ResponseA, mutate: Bool) {

    guard mutate == true else {
        return
    }
    
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

func handle(response: ResponseB, mutate: Bool ) -> ResponseB {
  
    guard mutate == true else {
        return response
    }
    
    var newheaders = response.headers
    newheaders["OAuth"] = "token here"
    
    switch response.body {
        case .plainText(let text):
            let newtext = text + "Additional information"
     

            let newResponse = ResponseB(body: .plainText(newtext),
                                        headers: newheaders )
            return newResponse
        default:
            print("Unknown response type")
            return ResponseB(body: .Nothing, headers: response.headers)
    }
    
}


/// Experiment goes here 
var structureTimes = [Double]() 
var classTimes = [Double]()

for i in 1...200 {
  
  let iterations = 100
  let size = 500*i 

  let payload = String(repeating: Character("~"), count: size)
  
  var a = ResponseA(body: .plainText(payload))
  var b = ResponseB(body: .plainText(payload), headers: [String:String]())

  let classTime = benchmark( {
    for _ in 0...iterations {
        handle(a, mutate: false)
    }
  })
  
  let structTime = benchmark( {
    for _ in 0...iterations {
        handle(b, mutate: false)
    }
  })
  
  classTimes.append(classTime)
  structureTimes.append(structTime) 

}


print(structureTimes)

print(classTimes)


