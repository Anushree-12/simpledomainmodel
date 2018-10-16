//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//
public struct Money {
  public var amount : Int
  public var currency : String
  
  public func convert(_ to: String) -> Money {
    var moneyConverted: Int = 0;
    if (self.currency == to) {
        return self
    }
    switch (currency, to) {
    case ("USD", "GBP"):
        moneyConverted = amount/2
        print(moneyConverted)
    case ("USD", "EUR"):
        moneyConverted = (amount * 3) / 2
    case ("USD", "CAN"):
        moneyConverted = (amount * 5) / 4
    case ("GBP", "USD"):
        moneyConverted = amount * 2
    case ("GBP", "EUR"):
        moneyConverted = (amount * 2 * 3) / 2
    case ("GBP", "CAN"):
        moneyConverted = (amount * 2 * 5) / 4
    case ("EUR", "GBP"):
        moneyConverted = (amount * 2 ) / 6
    case ("EUR", "USD"):
        moneyConverted = (amount * 2) / 3
    case ("EUR", "CAN"):
        moneyConverted = (amount * 2 * 5) / 12
    case ("CAN", "GBP"):
        moneyConverted = (amount * 4) / 10
    case ("CAN", "USD"):
        moneyConverted = (amount * 4) / 5
    case ("CAN", "EUR"):
        moneyConverted = (amount * 4 * 3) / 10
    default:
        return Money(amount: 0, currency: "Currency Abreviation is Not Recognized")
    }
    return Money(amount: moneyConverted, currency: to)
  }
  
  public func add(_ to: Money) -> Money {
    let money = self.convert(to.currency)
    let moneyAmount = money.amount
    return Money(amount: moneyAmount + to.amount, currency: to.currency)
  }
    
  public func subtract(_ from: Money) -> Money {
    let money = self.convert(from.currency)
    let moneyAmount = money.amount
    return Money(amount:moneyAmount - from.amount, currency: from.currency)
  }
}

////////////////////////////////////
// Job
//
open class Job {
  fileprivate var title : String
  fileprivate var type : JobType

  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
  }
  
  public init(title : String, type : JobType) {
    self.title = title
    self.type = type
  }
  
  open func calculateIncome(_ hours: Int) -> Int {
    switch type {
    case .Hourly(let hourly):
        return Int(hourly * Double(hours))
    case .Salary(let salary):
        return salary
    }
  }
  
  open func raise(_ amt : Double) {
    switch type {
    case .Hourly(let hourly):
        type = .Hourly(hourly + amt)
    case .Salary(let salary):
        type = .Salary(Int(Double(salary) + amt))
    }
  }
}

////////////////////////////////////
// Person
//
open class Person {
  open var firstName : String = ""
  open var lastName : String = ""
  open var age : Int = 0

  fileprivate var _job : Job? = nil
  open var job : Job? {
    get { return _job}
    set(value) {
        if age > 16 {
            _job = value
        }
    }
  }
  
  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get { return _spouse}
    set(value) {
        if age > 18 {
            _spouse = value
        }
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }
  
  open func toString() -> String {
    let familyToString: String = "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(String(describing: _job)) spouse:\(String(describing: _spouse))]"
    return familyToString
  }

}

////////////////////////////////////
// Family
//
open class Family {
  fileprivate var members : [Person] = []
  
  public init(spouse1: Person, spouse2: Person) {
    if spouse1.spouse == nil && spouse2.spouse == nil {
        spouse1.spouse = spouse2
        spouse2.spouse = spouse1
        members.append(spouse1)
        members.append(spouse2)
    }
  }
  
  open func haveChild(_ child: Person) -> Bool {
    if members[0].age > 21 || members[1].age > 21 {
        members.append(child)
        return true
    } else {
        return false
    }
  }
  
  open func householdIncome() -> Int {
    var income: Int = 0
    for human in self.members {
        if human.job != nil {
            income = income + (human.job?.calculateIncome(2000))!
        }
    }
    print(income)
    return(income)
  }
}





