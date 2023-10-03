//
//  ViewController.swift
//  CalcApp
//
//  Created by Vincent Joaquin on 9/3/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var calcWorkings: UILabel!
    @IBOutlet weak var calcResults: UILabel!
    
    var workings:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        clearAll()
    }
    
    func clearAll(){
        workings = ""
        calcWorkings.text = ""
        calcResults.text = ""
    }
    
    @IBAction func allClearTap(_ sender: Any) {
        clearAll()
    }
    
    @IBAction func backTap(_ sender: Any) {
        if(!workings.isEmpty){
            workings.removeLast()
            calcWorkings.text = workings
        }
    }
    
    func addToWorkings(value: String){
        workings = workings + value
        calcWorkings.text = workings
    }
    

    @IBAction func percTap(_ sender: Any) {
        addToWorkings(value: "%")
    }
    
    @IBAction func divTap(_ sender: Any) {
        addToWorkings(value: "/")
    }
    
    @IBAction func multTap(_ sender: Any) {
        addToWorkings(value: "*")
    }
    
    @IBAction func subTap(_ sender: Any) {
        addToWorkings(value: "-")
    }
    
    @IBAction func addTap(_ sender: Any) {
        addToWorkings(value: "+")
    }
    
    @IBAction func equalTap(_ sender: Any) {
        if(validInput()){
            workings = workings.replacingOccurrences(of: "e^", with: "exp")
            if(workings.contains("log") || workings.contains("ln") || workings.contains("exp")){
                var i = 0, stop = 0
                var strlen = workings.count
                while(i<strlen){
                    if(workings[workings.index(workings.startIndex, offsetBy: i)] == "g" || workings[workings.index(workings.startIndex, offsetBy: i)] == "p" || workings[workings.index(workings.startIndex, offsetBy: i)] == "n"){
                        if(workings[workings.index(workings.startIndex, offsetBy: i + 1)] == "("){
                            while(workings[workings.index(workings.startIndex, offsetBy: i)] != ")"){
                                i += 1
                            }
                            continue
                        }
                        workings.insert("(", at: workings.index(workings.startIndex, offsetBy: i + 1))
                        strlen += 1
                        i += 2
                        while(i<strlen && workings[workings.index(workings.startIndex, offsetBy: i)].isNumber){
                           
                            if(i == strlen - 1){
                                workings.insert(")", at: workings.endIndex)
                                strlen += 1
                                stop = 1
                                break
                            }
                            
                            if(!workings[workings.index(workings.startIndex, offsetBy: i+1)].isNumber){
                                workings.insert(")", at: workings.index(workings.startIndex, offsetBy: i + 1))
                                strlen += 1
                                i += 1
                                break
                            }
                            
                            i += 1
                        }
                       
                    }
                    if(stop == 1){
                        break
                    }
                    i += 1
                }
            }
            let checkedWorkingsForPercent = workings.replacingOccurrences(of: "%", with: "*0.01")
            let checkedWorkingsforPow = checkedWorkingsForPercent.replacingOccurrences(of: "^", with: "**")
            let expression = NSExpression(format: checkedWorkingsforPow)
            let result = expression.expressionValue(with: nil, context: nil) as! Double
            let resultString = formatResult(result: result)
            calcResults.text = resultString
        }
        else{
            let alert = UIAlertController(
                title: "Invalid Input",
                message: "Calculator unable to do math based on input",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func validInput() -> Bool{
        
        var count = 0
        var funcCharIndexes = [Int]()
        
        for char in workings{
            if(specialCharacter(char: char)){
                funcCharIndexes.append(count)
            }
            count += 1
        }
        
        var previous: Int = -1
        
        for index in funcCharIndexes{
            if(index == 0){
                return false
            }
            if(index == workings.count - 1){
                return false
            }
            if(previous != -1){
                if(index - previous == 1){
                    return false
                }
            }
            previous = index
        }
        
        return true
    }
    
    func specialCharacter (char: Character) -> Bool{
        if(char=="*"){
            return true
        }
        if(char=="/"){
            return true
        }
        if(char=="+"){
            return true
        }
        return false
        
    }
    
    func formatResult(result: Double) -> String{
        if(result.truncatingRemainder(dividingBy: 1) == 0){
            return String(format: "%.0f", result)
        }
        else{
            return String(format: "%.2f", result)
        }
    }
    
    @IBAction func decimalTap(_ sender: Any) {
        addToWorkings(value: ".")
    }
    
    @IBAction func nineTap(_ sender: Any) {
        addToWorkings(value: "9")
    }
    
    @IBAction func eightTap(_ sender: Any) {
        addToWorkings(value: "8")
    }
    
    
    @IBAction func sevenTap(_ sender: Any) {
        addToWorkings(value: "7")
    }
    
    
    @IBAction func sixTap(_ sender: Any) {
        addToWorkings(value: "6")
    }
    
    @IBAction func fiveTap(_ sender: Any) {
        addToWorkings(value: "5")
    }
    
    @IBAction func fourTap(_ sender: Any) {
        addToWorkings(value: "4")
    }
    
    @IBAction func threeTap(_ sender: Any) {
        addToWorkings(value: "3")
    }
    
    @IBAction func twoTap(_ sender: Any) {
        addToWorkings(value: "2")
    }
    
    
    @IBAction func oneTap(_ sender: Any) {
        addToWorkings(value: "1")
    }
    
    @IBAction func zeroTap(_ sender: Any) {
        addToWorkings(value: "0")
    }
    
    @IBAction func powTap(_ sender: Any) {
        addToWorkings(value: "^")
    }
    
    @IBAction func logTap(_ sender: Any) {
        addToWorkings(value: "log")
    }
    
    @IBAction func lnTap(_ sender: Any) {
        addToWorkings(value: "ln")
    }
    
    @IBAction func eTap(_ sender: Any) {
        addToWorkings(value: "e^")
    }
    
    
    
    
    
    
    
    
    
    
}
