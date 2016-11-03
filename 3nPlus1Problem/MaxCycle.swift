//
//  MaxCycle.swift
//  3nPlus1Problem
//
//  Created on: 04-May-2016
//      Author: Nafisa Rahman
//
//  LICENSE:-
//  The MIT License (MIT)
//  Copyright (c) 2016 Nafisa Rahman
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom
//  the Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall
//  be included in all copies or substantial portions of the
//  Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
//  OR OTHER DEALINGS IN THE SOFTWARE.
//

import Foundation

class MaxCycle {
    
    //MARK:- Properties
    
    //MARK: computation type
    var recursive = true
    
    //MARK: cycle length for each stopping number
    var cycleLength = 0
    
    //MARK: maximum cycle length for each stopping number between the input numbers
    var maxCycleLength = 0
    
    //MARK: stores each stopping number & it's cycle length
    struct Calculation {
        
        var inputNumber : Int
        var stoppingNumber: Int
        var cycle : Int
        
    }
    
    //MARK: array of structure to store all stopping number & cycle length
    var calculationSteps : [Calculation] = []
    
    //MARK: first input number
    var num1 : Int
    
    //MARK: second input number
    var num2 : Int
    
    //MARK: init
    init(num1 : Int, num2 : Int){
        
        self.num1 = num1
        self.num2 = num2
        
    }
    
    //MARK: instance of struct
    var myCalculation = Calculation(inputNumber: 0,stoppingNumber: 0,cycle: 0)
    
    //MARK:- Methods
    
    //MARK: calculation for all numbers between & including the input pair
    func inputPair() -> Int{
        
        //if first input is greater than second input then swap the numbers
        if num1 > num2 {
            //swap
            var temp = 0
            
            temp = num1
            num1 = num2
            num2 = temp
        }
        
        
        
        //for each numbers including and between the input numbers calculate cycle length
        for i in num1...num2{
            
            let valid = isValidNum(i)
            
            if valid{
                
                cycleLength = 0
                myCalculation.inputNumber = i
                
                if recursive {
                    cycleLength = compute_recurse(i)
                }
                else {
                    cycleLength = compute_iterate(i)
                    
                }
                
                getMaxCycleLength(cycleLength)
            }
        }
        
        return maxCycleLength
    }
    
    
    //MARK: checks whether the entered number is valid
    func isValidNum(_ num : Int)->Bool {
        
        if (num > 0) && (num < 10000) {
            return true
        }
        else {
            
            return false
        }
    }
    
    //MARK: computes the cycle length recursively
    func compute_recurse( _ num : Int) -> Int {
        
        var n = num
        
        cycleLength += 1
        
        myCalculation.stoppingNumber = n
        myCalculation.cycle = cycleLength
        
        calculationSteps.append(myCalculation)
        
        
        if n != 1 {
            //If the number is even, divide it by two
            if n%2 == 0 {
                n = n/2
                
            }
            else {
                //If the number is odd, triple it and add one
                n = (3 * n) + 1
            }
            
            //recursive call for new n
            compute_recurse(n)
        }
        
        return cycleLength
        
    }
    
    //MARK: computes the cycle length non recursively
    func compute_iterate( _ num : Int) -> Int {
        
        var n = num
        
        if ( n == 1){
            cycleLength += 1
            
            myCalculation.stoppingNumber = n
            myCalculation.cycle = cycleLength
            
            calculationSteps.append(myCalculation)
        }
        
        while(n != 1) {
            
            cycleLength += 1
            
            myCalculation.stoppingNumber = n
            myCalculation.cycle = cycleLength
            
            calculationSteps.append(myCalculation)
            
            if n != 1 {
                //If the number is even, divide it by two
                if n%2 == 0 {
                    n = n/2
                    
                }
                else {
                    //If the number is odd, triple it and add one
                    n = (3 * n) + 1
                }
            }
            
            if ( n == 1){
                
                cycleLength += 1
                
                myCalculation.stoppingNumber = n
                myCalculation.cycle = cycleLength
                
                calculationSteps.append(myCalculation)
            }
        }
        
        return cycleLength
        
    }
    
    //MARK: computes the max cycle length
    func getMaxCycleLength(_ cycleLength : Int){
        
        if maxCycleLength < cycleLength {
            maxCycleLength = cycleLength
        }
    }
    
}
