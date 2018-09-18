//
//  MainController.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/12/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import UIKit
import RxSwift
class MainController: BaseViewController {
    @IBOutlet weak var tbView: UITableView!
    var model = MainViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpRx()
        setUpTable()
        // Do any additional setup after loading the view.
    }
    
    func setUpRx(){
        model.data.asObservable()
            .subscribe(onNext: { //2
                data in
                self.tbView.reloadData()
            })
            .disposed(by: disposeBag) //3
    }
    
    func setUpTable(){
        tbView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: MainTableViewCell.reuseIdentifier)
    }

}

extension MainController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.amountData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath) as! MainTableViewCell
        let data = model.dataAtIndex(index: indexPath.row)
        cell.data = data
        return cell
    }
}

extension MainController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200//tableView.frame.height / CGFloat(model.amountData())
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 3:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "QuestionGroupViewController") as! QuestionGroupViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListSymbolViewController") as! ListSymbolViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListSymbolViewController") as! ListSymbolViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListSymbolViewController") as! ListSymbolViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case 7:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PromotionViewController") as! PromotionViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case 6:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TrickViewController") as! TrickViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case 5:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SAPhotosViewController") as! SAPhotosViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case 0:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "QuestionsViewController") as! QuestionsViewController
            let timer = Timer()
            vc.timerModel = TimerCountDown(timer: timer)
            vc.titles = model.dataAtIndex(index: indexPath.row).name
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReviewQuestionViewController") as! ReviewQuestionViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
