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

enum Body {
  
  case plainText(String)
  case data([UInt8])
  case Nothing
  
}

struct Version {
  
  var major: Int
  var minor: Int

}


final class ResponseA {

  var body: Body
  var headers = [String:String]()
  
  init(body: Body) {
    self.body = body
  }
  
}

struct ResponseB {
  var body: Body
  var headers = [String:String]()
}

/**
 This method mutates Response in place
 */
func handle(_ response: ResponseA) {

  switch response.body {
    case .plainText(let text):
      let newtext = text + "Additional information"
      response.headers["OAuth"] = "token here"
      response.body = .plainText(newtext)
    default:
      print("Unknown response type")
      return
  }
  
}

func handle(_ response: ResponseB) -> ResponseB {
  // mutate here
  switch response.body {
    case .plainText(let text):
      let newtext = text + "Additional information"
      var newheaders = response.headers
      newheaders["OAuth"] = "token here"

      let newResponse = ResponseB(body: .plainText(newtext),
        headers: newheaders )
      return newResponse
    default:
      print("Unknown response type")
      return ResponseB(body: .Nothing, headers: response.headers)
  }
}







func timestamp() -> Double {

  var tv = timeval()
  gettimeofday(&tv, nil)
  let t = Double(tv.tv_sec) + Double(tv.tv_usec)*1e-6
  return t
}

/**
 Benchmark a function

  parameter function: a function to profile 
*/
func benchmark(_ function: (Void)->Void) -> Double {

  let t1 = timestamp()
  function()
  let t2 = timestamp()

  return t2-t1

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


