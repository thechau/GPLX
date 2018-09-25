//
//  ResultViewController.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/13/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class ResultViewController: UIViewController {
    @IBOutlet weak var clvBottom: UICollectionView!
    @IBOutlet weak var lbWarning: UILabel!
    @IBOutlet weak var lbWrong: UILabel!
    @IBOutlet weak var lbCorrect: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbResult: UILabel!
    var model = QuestionViewModel()
    var time = ""
    var idQuestionGroup = ""
    weak var delegate : ResultProtocal!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setText()
        clvBottom.register(UINib(nibName: "ResultCell", bundle: nil), forCellWithReuseIdentifier: ResultCollectionViewCell.reuseIdentifier)
        // Do any additional setup after loading the view.
    }
    
    
    func setText(){
        lbTime.text = time
        lbCorrect.text = "\(model.getResult().correct)"
        lbWrong.text = "\(model.getResult().wrong)"
        lbWarning.text = "\(model.getResult().warning)"
        lbResult.text = model.getResult().result
    }
    
    

    @IBAction func onActionShareButton(_ sender: Any) {
        showSheet()
    }
    
    func showSheet(){
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "Lưu kết quả", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            if self.idQuestionGroup != ""{
                DatabaseManager.getInstance.createQuestionGroup(identifier: Int(self.idQuestionGroup)!,numberCorrect: self.model.getResult().correct, numberWrong: self.model.getResult().wrong, arrAnswer: self.model.getResultForReaml())
            }
            self.dissMissSheet(view: optionMenu)
        })
        
        let action3 = UIAlertAction(title: "Lưu câu Sai", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            
            
            for record in self.model.data{
                if record.correctlyAnswer != record.correctlyChoose && record.correctlyChoose.count > 0{
                    DatabaseManager.getInstance.createWrongQuestion(model: record)
                }
            }
            
            self.dissMissSheet(view: optionMenu)
        })
        
        let actionCancel = UIAlertAction(title: "Không Lưu", style: .cancel, handler:
        {
            (alert: UIAlertAction!) -> Void in
            //self.typeLincese = 3
            self.dissMissSheet(view: optionMenu)
        })
        
        if idQuestionGroup != ""{
            optionMenu.addAction(action1)
        }
        
        optionMenu.addAction(action3)
        optionMenu.addAction(actionCancel)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func dissMissSheet(view: UIAlertController){
        view.dismiss(animated: true, completion: nil)
        for vc in (self.navigationController?.viewControllers)!{
            if vc is MainController{
                self.navigationController?.popToViewController(vc, animated: true)
            }
        }
    }
}

extension ResultViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.amountData()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.reuseIdentifier, for: indexPath) as! ResultCollectionViewCell
        cell.data = model.dataAtIndex(index: indexPath.row)
        cell.lbNumberQuestion.text = "Câu: \(indexPath.row + 1)"
        
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension ResultViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.popViewController(animated: true)
        self.delegate.popView(index: indexPath.row)
    }
}

extension ResultViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 4, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
