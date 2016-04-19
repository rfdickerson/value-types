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


func total (trials: [Double]) -> Double {
    return trials.reduce(0, combine: +)
}

func average (trials: [Double]) -> Double {
    return total(trials) / Double(trials.count)
}


/**
 Benchmark a function
 
 parameter function: a function to profile
 */
func benchmark(function: (Void)->Void) -> (Double,Double) {
    
    let numTrials = 100
    
    var trials = [Double](repeating: 0, count: numTrials)
    
    for i in 1...numTrials {
        let t1 = timestamp()
        function()
        let t2 = timestamp()
        trials[i-1] = t2-t1
    
    }
    
    return (average(trials), 0)
    
}
