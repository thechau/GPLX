//
//  QuestionCollectionViewCell.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/13/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import UIKit

protocol ChooseAnswer: class{
    func choose(index: Int, model: QuestionModel)
}

class QuestionWithImageCollectionViewCell: UICollectionViewCell {
    class var reuseIdentifier: String {
        get {
            return "QuestionWithImageCollectionViewCell"
        }
    }
    
    var delegate: ChooseAnswer!
    
    var checked = false
    
    var chooseAnswer : [String] = []
    
    var index : Int = 0
    
    var correctAnswer : [String]? {
        didSet{
            for index in correctAnswer!{
                if index == "1"{
                    radio_asw1.isChecked = true
                }else if index == "2"{
                    radio_asw4.isChecked = true
                }else if index == "3"{
                    radio_asw4.isChecked = true
                }else if index == "4"{
                    radio_asw4.isChecked = true
                }
            }
        }
    }
    
    var data : QuestionModel? {
        willSet{
            chooseAnswer = []
            radio_asw1.isChecked = false
            radio_asw2.isChecked = false
            radio_asw3.isChecked = false
            radio_asw4.isChecked = false
            
            lbAnswer1.textColor = .black
            lbAnswer2.textColor = .black
            lbAnswer3.textColor = .black
            lbAnswer4.textColor = .black
            
        }
        didSet{
            guard let datas = data else {
                return
            }
            
            lbQuestion.text = datas.label
            lbAnswer1.text = datas.answer[0]
            lbAnswer2.text = datas.answer[1]
            lbAnswer3.text = datas.answer[2]
            lbAnswer4.text = datas.answer[3]
            
            if datas.image == ""{
                constraintForHeightOfImage.constant = 0
                constraintBottomOfImage.constant = 0
                
            }else{
                if (UIImage(named: "\(datas.image)-1") != nil) {
                    
                    imgQuestion.image = UIImage(named: "\(datas.image)-1")
                }
                else {
                    imgQuestion.image = UIImage(named: datas.image)
                }
                constraintBottomOfImage.constant = 20
                constraintForHeightOfImage.constant = 180
            }
            
            chooseAnswer = datas.correctlyChoose
            
            for index in datas.correctlyChoose{
                if index == "1"{
                    lbAnswer1.textColor = .blue
                    radio_asw1.isChecked = true
                    //radio_asw1.buttonClicked(sender: radio_asw1)
                }else if index == "2"{
                    lbAnswer2.textColor = .blue
                    radio_asw2.isChecked = true
                    //radio_asw2.buttonClicked(sender: radio_asw2)
                }else if index == "3"{
                    lbAnswer3.textColor = .blue
                    radio_asw3.isChecked = true
                    //radio_asw3.buttonClicked(sender: radio_asw3)
                }else if index == "4"{

                    lbAnswer4.textColor = .blue
                    radio_asw4.isChecked = true
                    //radio_asw4.buttonClicked(sender: radio_asw4)
                }
            }
            
            hiddenButton()
            
            if !checked{
                return
            }
            
            for index in datas.correctlyAnswer{
                if index == "1"{
                    lbAnswer1.textColor = .green
                    //radio_asw1.buttonClicked(sender: radio_asw1)
                }else if index == "2"{
                    
                    lbAnswer2.textColor = .green
                    //radio_asw2.buttonClicked(sender: radio_asw2)
                }else if index == "3"{
                    
                    lbAnswer3.textColor = .green
                    //radio_asw3.buttonClicked(sender: radio_asw3)
                }else if index == "4"{
                    
                    lbAnswer4.textColor = .green
                    //radio_asw4.buttonClicked(sender: radio_asw4)
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vwAnswer1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onActionButtonAnswer1)))
        vwAnswer2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onActionButtonAnswer2)))
        vwAnswer3.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onActionButtonAnswer3)))
        vwAnswer4.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onActionButtonAnswer4)))
    }
    
    @IBOutlet weak var constraintBottomOfImage: NSLayoutConstraint!
    @IBOutlet weak var constraintForHeightOfImage: NSLayoutConstraint!
    
    @IBOutlet weak var radio_asw4: CheckBox!
    @IBOutlet weak var radio_asw3: CheckBox!
    @IBOutlet weak var radio_asw2: CheckBox!
    @IBOutlet weak var radio_asw1: CheckBox!
    
    @IBOutlet weak var lbAnswer4: UILabelChecked!
    @IBOutlet weak var lbAnswer3: UILabelChecked!
    @IBOutlet weak var lbAnswer2: UILabelChecked!
    @IBOutlet weak var lbAnswer1: UILabelChecked!
    
    @IBOutlet weak var vwAnswer3: UIView!
    @IBOutlet weak var vwAnswer2: UIView!
    @IBOutlet weak var vwAnswer1: UIView!
    @IBOutlet weak var vwAnswer4: UIView!
    
    @IBOutlet weak var imgQuestion: UIImageView!
    @IBOutlet weak var lbQuestion: UILabel!
    
    @objc func onActionButtonAnswer2() {
        if checked{
            return
        }
        radio_asw2.isChecked = !radio_asw2.isChecked
        print("Touch2")
        if chooseAnswer.contains("2"){
            chooseAnswer.remove(at: chooseAnswer.index(of: "2")!)
            lbAnswer2.textColor = .black
        }else{
            chooseAnswer.append("2")
            lbAnswer2.textColor = .blue
        }
        data?.correctlyChoose = chooseAnswer
        delegate.choose(index: index, model: data!)
    }
    
    @objc func onActionButtonAnswer3() {
        print("Touch3")
        if checked{
            return
        }
        radio_asw3.isChecked = !radio_asw3.isChecked
        if chooseAnswer.contains("3"){
            chooseAnswer.remove(at: chooseAnswer.index(of: "3")!)
            lbAnswer3.textColor = .black
        }else{
            chooseAnswer.append("3")
            lbAnswer3.textColor = .blue
        }
        data?.correctlyChoose = chooseAnswer
        delegate.choose(index: index, model: data!)
    }
    
    @objc func onActionButtonAnswer1() {
        print("Touch1")
        if checked{
            return
        }
        radio_asw1.isChecked = !radio_asw1.isChecked
        if chooseAnswer.contains("1"){
            chooseAnswer.remove(at: chooseAnswer.index(of: "1")!)
            lbAnswer1.textColor = .black
        }else{
            chooseAnswer.append("1")
            lbAnswer1.textColor = .blue
        }
        data?.correctlyChoose = chooseAnswer
        delegate.choose(index: index, model: data!)
    }
    
    @objc func onActionButtonAnswer4() {
        print("Touch4")
        if checked{
            return
        }
        radio_asw4.isChecked = !radio_asw4.isChecked
        if chooseAnswer.contains("4"){
            chooseAnswer.remove(at: chooseAnswer.index(of: "4")!)
            lbAnswer4.textColor = .black
        }else{
            chooseAnswer.append("4")
            lbAnswer4.textColor = .blue
        }
        data?.correctlyChoose = chooseAnswer
        delegate.choose(index: index, model: data!)
    }
    
    func hiddenButton(){
        if lbAnswer4.text == ""{
            vwAnswer4.isHidden = true
            radio_asw4.isHidden = true
        }else{
            vwAnswer4.isHidden = false
            radio_asw4.isHidden = false
        }
        
        if lbAnswer1.text == ""{
            vwAnswer1.isHidden = true
            radio_asw1.isHidden = true
        }else{
            vwAnswer1.isHidden = false
            radio_asw1.isHidden = false
        }
        
        if lbAnswer3.text == ""{
            
            vwAnswer3.isHidden = true
            radio_asw3.isHidden = true
        }else{
            vwAnswer3.isHidden = false
            radio_asw3.isHidden = false
        }
        
        if lbAnswer2.text == ""{
            vwAnswer2.isHidden = true
            radio_asw2.isHidden = true
        }else{
            vwAnswer2.isHidden = false
            radio_asw2.isHidden = false
        }
    }
    
    
}
