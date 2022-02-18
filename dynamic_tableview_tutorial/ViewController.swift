//
//  ViewController.swift
//  dynamic_tableview_tutorial
//
//  Created by 김병엽 on 2022/02/17.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // MARK: - outlet
    @IBOutlet weak var prependButton: UIBarButtonItem!
    @IBOutlet weak var resetButton: UIBarButtonItem!
    @IBOutlet weak var appendButton: UIBarButtonItem!
    
    var myTableView: UITableView = {
        let tV = UITableView()
        return tV
    }()
    
    var appendingCount: Int = 0
    var prependingCount: Int = 0
    
    var prependingArray = ["1 앞에 추가", "2 앞에 추가", "3 앞에 추가", "4 앞에 추가", "5 앞에 추가", "6 앞에 추가"]
    var addingArray = ["1 뒤에 추가", "2 뒤에 추가", "3 뒤에 추가", "4 뒤에 추가", "5 뒤에 추가", "6 뒤에 추가"]
    var tempArray: [String] = []
    
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
    
    // MARK: - action Button methods
    
    @IBAction func barButtonAction(_ sender: UIBarButtonItem) {
        print(#function, #line, "")
        
        switch sender {
        case prependButton:
            self.prependData()
        case resetButton:
            self.resetData()
        case appendButton:
            self.appendData()
        default:
            break
        }
    }
}

    // MARK: - tableViewDelegate methods
extension ViewController: UITableViewDelegate {
    
}

    // MARK: - tableViewDataSource methods
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tempArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myTableViewCell", for: indexPath) as! MyTableViewCell
        
        cell.userContentLabel.text = self.tempArray[indexPath.row]
        cell.tableItemCount.text = String(indexPath.row)
        
        return cell
    }
}
    // MARK: - 테이블 뷰 관련 메소드
extension ViewController {
    
    fileprivate func prependData() {
        print(#function, #line, "")
        self.tempArray.insert(contentsOf: prependingArray, at: 0)
        self.myTableView.reloadDataAndKeepOffset()
    }
    
    fileprivate func appendData() {
        print(#function, #line, "")
        self.tempArray += addingArray
        self.myTableView.reloadData()
    }
    
    fileprivate func resetData() {
        print(#function, #line, "")
        self.tempArray = []
        self.myTableView.reloadData()
    }
}

extension UITableView {
    
    func reloadDataAndKeepOffset() {
        // 스크롤링 멈추기
        //setContentOffset(contentOffset, animated: false)
        
        // 데이터 추가 전 컨텐츠 사이즈
        let beforeContentSize = contentSize
        reloadData()
        layoutIfNeeded()
        
        // 데이터 추가 후 컨텐츠 사이즈
        let afterContentSize = contentSize
        
        // 데이터가 변경되고 리로드 되고 나서 컨텐츠 옵셋 계산 및 설정
        let calculatednewOffset = CGPoint(
            x: contentOffset.x + (afterContentSize.width - beforeContentSize.width),
            y: contentOffset.y + (afterContentSize.height - beforeContentSize.height)
        )
        
        // 변경된 옵셋 설정
        setContentOffset(calculatednewOffset, animated: false)
    }
}

