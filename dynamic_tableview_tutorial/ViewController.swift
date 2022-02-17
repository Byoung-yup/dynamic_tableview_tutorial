//
//  ViewController.swift
//  dynamic_tableview_tutorial
//
//  Created by 김병엽 on 2022/02/17.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var myTableView: UITableView = {
        let tV = UITableView()
        return tV
    }()
    
    var contentArray = [
    "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    
    "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    
    "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
    
    "The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy.",
    
    "Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
    
    "The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham."
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.uiSetUp()
        self.registerNib()
        self.delegateSetUp()
    }

    // MARK: - delegate Setup methods
    fileprivate func delegateSetUp() {
        myTableView.dataSource = self
        myTableView.delegate = self
    }
    
    // MARK: - UI Setup methods
    fileprivate func uiSetUp() {
        
        // 테이블 뷰
        self.view.addSubview(myTableView)
        myTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    // MARK: - cell Nib register methods
    fileprivate func registerNib() {
        
        // 쎌 리소스 파일 가져오기
        let myTableViewCellNib = UINib(nibName: String(describing: MyTableViewCell.self), bundle: nil)
        
        // 쎌에 리소스 등록
        self.myTableView.register(myTableViewCellNib, forCellReuseIdentifier: "myTableViewCell")
        
        // 쎌 높이 동적으로 설정
        self.myTableView.rowHeight = UITableView.automaticDimension
        // 쎌 예상 높이 설정
        self.myTableView.estimatedRowHeight = 120
    }
}

    // MARK: - tableViewDelegate methods
extension ViewController: UITableViewDelegate {
    
}

    // MARK: - tableViewDataSource methods
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.contentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myTableViewCell", for: indexPath) as! MyTableViewCell
        
        cell.userContentLabel.text = self.contentArray[indexPath.row]
        
        return cell
    }
    
    
}

