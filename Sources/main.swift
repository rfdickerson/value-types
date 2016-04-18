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
