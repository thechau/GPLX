//
//  QuestionsViewController.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/13/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

class QuestionsViewController: BaseViewController {

    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var clvBottom: UICollectionView!
    @IBOutlet weak var clvTop: UICollectionView!
    var model = QuestionViewModel()
    var timerModel : TimerCountDown!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerModel.value
            .asObservable()
            .subscribe(onNext: { //2
                data in
                self.lbTime.text = data
            })
            .disposed(by: disposeBag) //3)
        setUpCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      //  timerModel.start()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       // timerModel.stop()
    }
    
    @IBAction func onActionResultButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func setUpCollectionView(){
        clvTop.register(UINib(nibName: "TopQuestionCell", bundle: nil), forCellWithReuseIdentifier: TopQuestionCollectionViewCell.reuseIdentifier)
        clvBottom.register(UINib(nibName: "QuestionCellWithImage", bundle: nil), forCellWithReuseIdentifier: QuestionWithImageCollectionViewCell.reuseIdentifier)
    }
    
}

extension QuestionsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.amountData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = model.dataAtIndex(index: indexPath.row)
        if collectionView == clvTop{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopQuestionCollectionViewCell.reuseIdentifier, for: indexPath) as! TopQuestionCollectionViewCell
            cell.data = AnswerModel(index: indexPath.row, color: .white, correct: true)
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuestionWithImageCollectionViewCell.reuseIdentifier, for: indexPath) as! QuestionWithImageCollectionViewCell
        cell.data = data
        return cell
        
    }
}

extension QuestionsViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == clvTop{
            return CGSize(width: clvTop.frame.width, height: clvTop.frame.height)
        }
        return CGSize(width: clvBottom.frame.width, height: clvBottom.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension QuestionsViewController: UICollectionViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Int(clvBottom.contentOffset.x / clvTop.frame.width)
        clvTop.scrollToItem(at: IndexPath(item: currentPage, section: 0), at: .right, animated: false)
    }
    
}
























