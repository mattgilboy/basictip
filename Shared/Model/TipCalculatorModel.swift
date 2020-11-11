//
//  CalculatorModel.swift
//  TipCalculator
//
//  Created by Matt Gilboy on 11/11/20.
//  Copyright © 2020 Matt Gilboy. All rights reserved.
//

import Foundation

let defaultTipPercent = 20.0

class TipCalculatorModel: ObservableObject {
    
    // Calculator Input
    @Published var bill = "" {
        didSet {
            update()
        }
    }
    @Published var split = "" {
        didSet {
            update()
        }
    }
    @Published var tipPercent = defaultTipPercent {
        didSet {
            update()
        }
    }
    @Published var tipPercentString = "" {
        didSet {
            if let tipPercentValue = Double(tipPercentString) {
                tipPercent = tipPercentValue
            } else if tipPercentString == "" {
                tipPercent = defaultTipPercent
            }
        }
    }
    @Published var roundUp = false {
        didSet {
            update()
        }
    }
    
    @Published var botTipValue: Int
    @Published var topTipValue: Int

    // Settings Input
    @Published var botTipString: String
    @Published var topTipString: String
    
    // Calculated
    var tip: Double
    var perPerson: Double
    var total: Double
    
    func update() {
        if let billValue = Double(bill) {
            let splitValue = Double(split) ?? 1.0
            if billValue >= 0 && splitValue > 0  {
                tip = billValue * tipPercent / 100
                total = billValue + tip
                perPerson = total / splitValue

                if roundUp == true {
                    perPerson = ceil(perPerson)
                    total = perPerson * splitValue
                }
            } else {
                tip = 0.00
                perPerson = 0.00
                total = 0.00
            }
        }
    }
    
    func updateTipRange() {
        if let botTipPercentValue = Int(botTipString) {
            if let topTipPercentValue = Int(topTipString) {
                if (botTipPercentValue < topTipPercentValue) {
                    botTipValue = botTipPercentValue
                    topTipValue = topTipPercentValue
                    UserDefaults.standard.set(botTipValue, forKey: "botTipRange")
                    UserDefaults.standard.set(topTipValue, forKey: "topTipRange")
                    
                    if tipPercent < Double(botTipValue) {
                        tipPercent = Double(botTipValue)
                    } else if tipPercent > Double(topTipValue) {
                        tipPercent = Double(topTipValue)
                    }

                    update()
                    return
                }
            }
        } else {
            // Input error, reset to old values
            botTipString = String(botTipValue)
            topTipString = String(topTipValue)
        }
    }
    
    func validBill() -> Bool {
        if Double(bill) != nil {
            return true
        } else {
            return false
        }
    }
    
    func validSplit() -> Bool {
        if Double(split) != nil {
            return true
        } else {
            return false
        }
    }
    
    func validTipPercentString() -> Bool {
        if Double(tipPercentString) != nil {
            return true
        } else {
            return false
        }
    }
    
    func validTipRange() -> Bool {
        if let botTipPercentValue = Int(botTipString) {
            if let topTipPercentValue = Int(topTipString) {
                if (botTipPercentValue < topTipPercentValue) {
                    return true
                }
            }
        }
        return false
    }
    
    func incrementSplit() {
        if var splitValue = Int(split) {
            splitValue += 1
            split = String(splitValue)
        } else if split == "" {
            // Handles first increment on watchOS
            split = "2"
        }
    }
    
    func decrementSplit() {
        if var splitValue = Int(split) {
            if splitValue > 1 {
                splitValue -= 1
                split = String(splitValue)
            }
        }
    }
    
    func incrementSplitEnabled() -> Bool {
        // No maximum split value enforced
        return true
    }
    
    func decrementSplitEnabled() -> Bool {
        if split == "" || split == "1" {
            return false
        } else {
            return true
        }
    }
    
    init() {
        if !UserDefaults.standard.bool(forKey: "firstRun") {
            UserDefaults.standard.set(15, forKey: "botTipRange")
            UserDefaults.standard.set(25, forKey: "topTipRange")
            UserDefaults.standard.set(true, forKey: "firstRun")
        }
        
        tip = 0.00
        perPerson = 0.00
        total = 0.00
        
        botTipValue = UserDefaults.standard.integer(forKey: "botTipRange")
        topTipValue = UserDefaults.standard.integer(forKey: "topTipRange")
        botTipString = String(UserDefaults.standard.integer(forKey: "botTipRange"))
        topTipString = String(UserDefaults.standard.integer(forKey: "topTipRange"))
    }
}
