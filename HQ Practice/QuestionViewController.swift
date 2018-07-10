//
//  QuestionViewController.swift
//  HQ Practice
//
//  Created by Noah Rubin on 7/10/18.
//  Copyright © 2018 Noah Rubin. All rights reserved.
//

import UIKit
import Foundation


class QuestionViewController: UIViewController {
    
    var categoryId = 1
    var correctAnswer = ""
    var answerChoices = [String]()
    var ready = true
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var diffucultyLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    var buttons = [UIButton]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttons = [button1, button2, button3, button4]
        let query = "https://opentdb.com/api.php?amount=1&category=\(categoryId)&type=multiple"
        DispatchQueue.global(qos: .userInitiated).async {
            [unowned self] in
            if let url = URL(string: query) {
                if let data = try? Data(contentsOf: url) {
                    let json = try! JSON(data: data)
                    if json["results"]["question"] != ""{
                        self.parse(json: json)
                        return
                    }
                }
            }
            self.loadError()
        }
        // Do any additional setup after loading the view.
    }
    
    func parse(json: JSON){
        for result in json["results"].arrayValue {
            //let question = result["question"]
            print(result["question"])
            //let dif = result["difficulty"]
            correctAnswer = result["correct_answer"].stringValue
            let index = Int(arc4random_uniform(UInt32(3)))
            for incorrect in result["incorrect_answers"].arrayValue {
                let add = incorrect.stringValue
                answerChoices.append(add)
            }
            answerChoices.insert(correctAnswer, at: index)
            for i in 0...buttons.count-1{
                buttons[i].titleLabel?.text = answerChoices[i]
            }

            diffucultyLabel.text = result["difficulty"].stringValue
            questionLabel.text = result["question"].stringValue
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadError(){
        DispatchQueue.main.async {
            [unowned self] in
            let alert = UIAlertController(title: "Loading Error",
                                          message: "There was a problem loading the questions ~ try connecting to internet or turning off airplane-mode",
                                          preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    static func stringify(json: Any, prettyPrinted: Bool = false) -> String {
        var options: JSONSerialization.WritingOptions = []
        if prettyPrinted {
            options = JSONSerialization.WritingOptions.prettyPrinted
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: options)
            if let string = String(data: data, encoding: String.Encoding.utf8) {
                return string
            }
        } catch {
            print(error)
        }
        
        return ""
    }
    
    @IBAction func aButtonTapped(_ sender: UIButton) {
        if(sender.titleLabel?.text == correctAnswer && ready){
            print("Correct")
            sender.backgroundColor = .green
            ready = false
        }
        else{
            print("Incorrect")
            sender.backgroundColor = .red
            ready = false
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
