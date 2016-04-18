import Foundation

enum Body {
  case simpleText(String)
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
    case .simpleText(let text):
    let newtext = text + "Additional information"

    response.headers["OAuth"] = "token here"
    response.body = .simpleText(newtext)
  }
}

func handle(_ response: ResponseB) -> ResponseB {
  // mutate here
  switch response.body {
  case .simpleText(let text):
    let newtext = text + "Additional information"
    var newheaders = response.headers
    newheaders["OAuth"] = "token here"

    let newResponse = ResponseB(body: .simpleText(newtext),
      headers: newheaders 
      )
    return newResponse
  }
  
}


let payload = String(repeating: Character("~"), count: 5000000)

var a = ResponseA(body: .simpleText(payload))
var b = ResponseB(body: .simpleText(payload), headers: [String:String]())

func getTime() 
{

}

func timestamp() -> Double {

  var tv = timeval()
  gettimeofday(&tv, nil)
  let t = Double(tv.tv_sec) + Double(tv.tv_usec)*1e-6
  return t
}

func benchmark(_ function: (Void)->Void) -> Double {

  let t1 = timestamp()
  function()
  let t2 = timestamp()

  return t2-t1

}

let classTime = benchmark( {
  for i in 0...1000000 {
    handle(a)
  }
})

let structTime = benchmark( {
  for i in 0...1000000 {
    handle(b)
  }
})


print("Using structures was \(structTime) ms")

print("Using classes was \(classTime) ms")
