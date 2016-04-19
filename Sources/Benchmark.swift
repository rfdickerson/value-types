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
func benchmark(function: (Void)->Void) -> Double {
    
    let t1 = timestamp()
    function()
    let t2 = timestamp()
    
    return t2-t1
    
}
