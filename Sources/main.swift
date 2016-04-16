import Foundation

enum Body {
  case simpleText(String)
}

struct Version {
  var major: Int
  var minor: Int
}

class ResponseA {

  var body: Body


  init(body: Body) {
    self.body = body
  }

}

struct ResponseB {

  var body: Body

}

func handle(_ response: ResponseA) {

  switch response.body {
    case .simpleText(let text):
    let newtext = text + "Additional information"

    response.body = .simpleText(newtext)
  }
}

func handle(_ response: ResponseB) -> ResponseB {
  // mutate here
  switch response.body {
  case .simpleText(let text):
    let newtext = text + "Additional information"

    let newResponse = ResponseB(body: .simpleText(newtext))
    return newResponse
  }
  
}


let payload = String(repeating: Character("~"), count: 5000000)

var a = ResponseA(body: .simpleText(payload))
var b = ResponseB(body: .simpleText(payload))

//for i in 0...100000 {
//  b = handle( b)
//}

for i in 0...100000 {
  handle(a)
}
// print(b.body) 
