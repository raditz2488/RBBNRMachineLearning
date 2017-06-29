//: Playground - noun: a place where people can play

import UIKit

let data:[[Double]] = [
    [3, 10],
    [15, 4],
    [30,35],
    [10,12],
    [7, 5 ],
    [35,30],
    [25,25],
    [20,23],
    [30,27],
    [17,13],
    [15,20],
]

// The model y = mx + b, b we will assume 0 for simplicity.
let lineThroughOrigin: (Double, Double) -> Double = { (slope, x) in slope * x }

// The loss
let meanErrors: ([[Double]], (Double, Double) -> Double, Double) -> Double = { (data, model, slope) in
    let errors = data.map{ model(slope, $0[0]) - $0[1] }
    return errors.reduce(0, +) / Double(errors.count)
}

// The minimizers i.e finding the best value of slope for the model which has lowest error
let minimize: (Double, Int) -> Double = { (learningRate, iterations) in
    var slope = 0.0
    for iteration in 1...iterations {
        let loss = meanErrors(data, lineThroughOrigin, slope)
        let direction = loss < 0 ? 1.0 : -1.0
        let step = direction * learningRate / Double(iteration)
        slope += step
    }
    return slope
}

let learntSlope = minimize(0.2, 100)
let predictedValue = lineThroughOrigin(learntSlope, 40)
print("Learnt Slope:\(learntSlope)")
print("Predicted y value from the learnt slope for x value of 40:\(predictedValue)")

