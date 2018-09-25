//
//  QuestionGroupViewController.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/13/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import UIKit
//import RxSwift

class QuestionGroupViewController: BaseViewController {
    var model = QuestionGroupViewModel()
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Bộ Câu Hỏi"
        
        collectionView.register(UINib(nibName: "QuestionGroupCell", bundle: nil), forCellWithReuseIdentifier: QuestionGroupCollectionViewCell.reuseIdentifier)
        // Do any additional setup after loading the view.
    }

}

extension QuestionGroupViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuestionGroupCollectionViewCell.reuseIdentifier, for: indexPath) as! QuestionGroupCollectionViewCell
        cell.lbNameQuestion.text = "Bộ \(indexPath.row)"
        if let data = model.dataAtIndex(index: indexPath.row){
            cell.data = data
        }else{
            cell.data = QuestionGroupSaved()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16//model.amountData()
    }
    
}

extension QuestionGroupViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "QuestionsViewController") as! QuestionsViewController
        let data = model.dataAtIndex(index: indexPath.row)
        if let _ = data?.arrAnswer{
            if data?.numberWrong != 0 || data?.numberCorrect != 0{
                vc.dataChooseAnswer = (data?.arrAnswer)!
            }
        }
        vc.id = "\(indexPath.row + 1)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension QuestionGroupViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 5, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
