//
//  ReviewQuestionViewController.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/14/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import UIKit

class ReviewQuestionViewController: UIViewController {

    @IBOutlet weak var TbView: UITableView!
    var model = ReviewQuestionViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        TbView.register(UINib(nibName: "ReviewQuestionCell", bundle: nil), forCellReuseIdentifier: ReviewQuestionTableViewCell.reuseIdentifier)
        // Do any additional setup after loading the view.
        TbView.rowHeight = 120
    }

}

extension ReviewQuestionViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.amoutData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewQuestionTableViewCell.reuseIdentifier, for: indexPath) as! ReviewQuestionTableViewCell
        let data = model.dataAtIndex(index: indexPath.row)
        cell.data = data
        return cell
    }
}

extension ReviewQuestionViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "QuestionsViewController") as! QuestionsViewController
        vc.idReview = indexPath.row + 1
        vc.checked = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
