//
//  NativeScenario.swift
//  Pods
//
//  Created by Sam Dean on 05/11/2015.
//
//

import Foundation

class NativeScenario : CustomStringConvertible {
    let scenarioDescription: String
    let stepDescriptions: [String]
    let index: Int

    /**
     If the scenario description is 'Test funny things are funny' then the result of calling
     `selectorName` would be `testTestFunnyThingsAreFunny`
     */
    var selectorString: String {
        get { return "test\(self.leftPad(index))\(self.scenarioDescription.camelCaseify)" }
    }
    
    var selectorCString: UnsafeMutablePointer<Int8> {
        get { return strdup(self.selectorString) }
    }
    
    required init(_ description: String, steps: [String], index: Int = 0) {
        self.scenarioDescription = description
        self.stepDescriptions = steps
        self.index = index
    }
    
    var description: String {
        get {
            return "<\(type(of: self)) \(self.selectorString) \(self.stepDescriptions.count) steps>"
        }
    }
    
    private func leftPad(_ index: Int) -> NSString {
        return NSString(format: "%03i", index)
    }
}

// The "Background" is a number of steps executed before every scenario, so this can be modelled as another scenario.
class NativeBackground: NativeScenario {
    
}
