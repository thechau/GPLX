//
//  QuestionsViewController.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/13/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import UIKit

//import RxCocoa
//import RxSwift
import RealmSwift

protocol ResultProtocal: class {
    func popView(index: Int)
}

class QuestionsViewController: BaseViewController {

    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var clvBottom: UICollectionView!
    @IBOutlet weak var clvTop: UICollectionView!
    
    @IBOutlet weak var bbtnResult: UIBarButtonItem!
    @IBOutlet weak var constraintLeadingBtnOpenList: NSLayoutConstraint!
    @IBOutlet weak var constraintTopBtnOpenList: NSLayoutConstraint!
    @IBOutlet weak var clvListQuestion: UICollectionView!
    @IBOutlet weak var btnOpenList: UIButton!
    @IBOutlet weak var constraintHeightClvList: NSLayoutConstraint!
    
    @IBOutlet weak var constraintWidthClvList: NSLayoutConstraint!
    
    var model = QuestionViewModel()
    var timerModel : TimerCountDown!
   // let disposeBag = DisposeBag()
    
    var id = ""
    var idReview = -1
    var arrRandom = [Int]()
    var arrWrongAnswar   = [AnswerModelCorrectOrWrong]()
    var dataChooseAnswer = List<String>()
    
    var timer = Timer()
    var value = ""
    var minutes = 15
    var seconds = 0
    var typeLincese = 0
    var fromRandom = false
    var checked = false
    var isReviewWroingQuestion = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        
        if isReviewWroingQuestion{
            showWrongQuestion()
        }else{
            getDataFromCSV()
        }
        if fromRandom{
            showSheet()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !fromRandom{
            start()
        }
        self.title = "Câu Hỏi"
    }
    
    
    @IBAction func onActionOpenList(_ sender: Any) {
        UIView.animate(withDuration: 3, animations: {
            if self.clvListQuestion.isHidden{

                self.btnOpenList.setTitle("Đóng",for: .normal)
                self.constraintLeadingBtnOpenList.constant = 30
                self.constraintTopBtnOpenList.constant = 30
                self.constraintWidthClvList.constant =  UIScreen.main.bounds.width
                self.constraintHeightClvList.constant =  self.view.frame.height - 68
            }else{
                
                self.btnOpenList.setTitle("Danh Sách",for: .normal)
                self.constraintLeadingBtnOpenList.constant = 10
                self.constraintTopBtnOpenList.constant = 10
                self.constraintWidthClvList.constant = 0
                self.constraintHeightClvList.constant = 0
            }
            
            self.clvListQuestion.isHidden = !self.clvListQuestion.isHidden
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stop()
    }
    
    func showSheet(){
        let optionMenu = UIAlertController(title: nil, message: "Chọn Loại Bằng", preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "A", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.typeLincese = 1
            self.dissMissSheet(view: optionMenu)
        })
        
        let action2 = UIAlertAction(title: "B1", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.typeLincese = 2
            self.dissMissSheet(view: optionMenu)
        })
        
        let action3 = UIAlertAction(title: "B2", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.typeLincese = 3
            self.dissMissSheet(view: optionMenu)
        })
        
        let actionCancel = UIAlertAction(title: "Đóng", style: .cancel, handler:
        {
            (alert: UIAlertAction!) -> Void in
            //self.typeLincese = 3
            self.dissMissSheet(view: optionMenu)
        })
        
        optionMenu.addAction(action1)
        optionMenu.addAction(action2)
        optionMenu.addAction(action3)
        optionMenu.addAction(actionCancel)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func dissMissSheet(view: UIAlertController){
        start()
        view.dismiss(animated: true, completion: nil)
    }
    
    func getDataFromCSV(){
        var data = readDataFromCSV(fileName: "questions", fileType: "csv")
        data = cleanRows(file: data!)
        let csvRows = csv(data: data!)
        model.setData(datas: csvRows)
        setArrRandom()
    }
    
    func showWrongQuestion(){
        checked = true
        model.getListWrongQuestion()
        for i in 0...model.amountData(){
            arrRandom.append(i)
            stop()
            lbTime.text = ""
            bbtnResult.isEnabled = false
            lbTime.isHidden = true
        }
        clvTop.reloadData()
        clvBottom.reloadData()
    }
    
    func setArrRandom(){
        if idReview != -1{
            getListReview()
        }else if id == ""{
            getRandomNumbers()
        }else{
            
            getGroupQuestion()
            if dataChooseAnswer.count > 0{
                model.convertListToArray(list: dataChooseAnswer) // appen list answer to model
            }
        }
        
        model.dataAfterRandom(arr: arrRandom)
        
        clvTop.reloadData()
        clvBottom.reloadData()
    }
    
    func getListReview(){
        if idReview == 1 {
            for i in 0...351{
                arrRandom.append(i)
            }
        }else if idReview == 2{
            for i in 0...131{
                arrRandom.append(i)
            }
        }else if idReview == 3{
            for i in 132...156{
                arrRandom.append(i)
            }
        }else if idReview == 4{
            for i in 157...256{
                arrRandom.append(i)
            }
        }else if idReview == 5{
            for i in 257...351{
                arrRandom.append(i)
            }
        }
    }
    
    func getRandomNumbers(){
        var randomNumbers = [Int]()
        while randomNumbers.count < 20 {
            let randomNumber = Int(arc4random_uniform(UInt32(model.amountData())))
            randomNumbers.append(randomNumber)
        }
        arrRandom = randomNumbers
    }
    
    func getGroupQuestion(){
        var data = readDataFromCSV(fileName: "exams", fileType: "csv")
        data = cleanRows(file: data!)
        let csvRows = csv(data: data!)
        arrRandom = model.getGroupQuestion(data: csvRows, id: id)
    }
    
    @IBAction func onActionResultButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        vc.model = model
        vc.time = lbTime.text!
        vc.idQuestionGroup = id
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func setUpCollectionView(){
        clvTop.register(UINib(nibName: "TopQuestionCell", bundle: nil), forCellWithReuseIdentifier: TopQuestionCollectionViewCell.reuseIdentifier)
        clvBottom.register(UINib(nibName: "QuestionCellWithImage", bundle: nil), forCellWithReuseIdentifier: QuestionWithImageCollectionViewCell.reuseIdentifier)
        clvListQuestion.register(UINib(nibName: "TopQuestionCell", bundle: nil), forCellWithReuseIdentifier: TopQuestionCollectionViewCell.reuseIdentifier)
    }
    
}
// Timer
extension QuestionsViewController{
    @objc func caculateValue(){
        switch seconds{
        case 0:
            minutes -= 1
            seconds = 59
        case 1..<60:
            seconds -= 1
        default:
            break
        }
        if seconds > 9{
            value = minutes > 9 ? "\(minutes):\(seconds)" : "0\(minutes):\(seconds)"
        }else{
            value = minutes > 9 ? "\(minutes):0\(seconds)" : "0\(minutes):0\(seconds)"
        }
        if minutes == 0 && seconds == 0{
            value = "Hết giờ"
            timer.invalidate()
        }
        if minutes < 3{
            lbTime.textColor = .red
        }
        lbTime.text = value
    }
    
    func start(){
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.caculateValue), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    func stop(){
        timer.invalidate()
    }
}

extension QuestionsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == clvListQuestion{
            
            return model.amountData() + 1
        }
        return model.amountData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == clvTop{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopQuestionCollectionViewCell.reuseIdentifier, for: indexPath) as! TopQuestionCollectionViewCell
            cell.data = AnswerModel(index: indexPath.row + 1, color: .white, correct: true)
            return cell
        }else if collectionView == clvBottom{
            let data = model.dataAtIndex(index: indexPath.row)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuestionWithImageCollectionViewCell.reuseIdentifier, for: indexPath) as! QuestionWithImageCollectionViewCell
            cell.checked = checked
            cell.data = data
            cell.index = indexPath.row
            cell.delegate = self
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopQuestionCollectionViewCell.reuseIdentifier, for: indexPath) as! TopQuestionCollectionViewCell
            cell.data = AnswerModel(index: indexPath.row, color: .white, correct: true)
            if indexPath.row != 0 {
                cell.vwBackground.backgroundColor = hexStringToUIColor(hex: "fad9c1")
                cell.vwBackground.setConerRaiousFollowWidth(width: 5)
                cell.lbTitle.textColor = .white
            }else{
                cell.vwBackground.backgroundColor = .white
            }
            return cell
        }
        
    }
}

extension QuestionsViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == clvTop{
            return CGSize(width: clvTop.frame.width, height: clvTop.frame.height)
        }else if collectionView == clvBottom{
            return CGSize(width: clvBottom.frame.width, height: clvBottom.frame.height)
        }
        return CGSize(width: clvBottom.frame.width / 4, height: clvBottom.frame.width / 4)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == clvListQuestion{
            UIView.animate(withDuration: 1, animations: {
                self.btnOpenList.setTitle("Danh Sách",for: .normal)
                self.constraintTopBtnOpenList.constant = 10
                self.constraintLeadingBtnOpenList.constant = 10
                self.constraintWidthClvList.constant = 0
                self.constraintHeightClvList.constant = 0
                self.clvListQuestion.isHidden = true
            })
            let indexPath = IndexPath(item: indexPath.row - 1, section: 0)
            clvBottom.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            
        }
    }
    
}

extension QuestionsViewController: ChooseAnswer{
    func choose(index: Int, model: QuestionModel) {
        self.model.data[index] = model
    }
}

extension QuestionsViewController: ResultProtocal{
    func popView(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        lbTime.text = ""
        lbTime.isHidden = true
        checked = true
        clvBottom.reloadData()
        clvBottom.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
























