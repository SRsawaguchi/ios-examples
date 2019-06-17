//
//  ViewController.swift
//  ChangeTableViewCellHeightDynamic
//
//  Created by Naoya Sawaguchi on 2019/06/17.
//  Copyright © 2019 Naoya Sawaguchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var pinchScale: CGFloat?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func didPinch(_ sender: UIPinchGestureRecognizer) {
        // ピンチスケールを取得
        pinchScale = sender.scale
        
        // TableViewを再描画させる
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // ピンチスケールにしたがってCellの高さを調整
        let defaultCellHeight = CGFloat(50)
        guard let scale = pinchScale else {
            return defaultCellHeight
        }
        return defaultCellHeight * scale
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
    }
    
    
}
