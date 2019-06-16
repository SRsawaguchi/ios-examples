//
//  ViewController.swift
//  SaveTextFileExample
//
//  Created by Naoya Sawaguchi on 2019/06/15.
//  Copyright © 2019 Naoya Sawaguchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var messageLabel: UILabel!
    
    private var fileUrl: URL {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return dir.appendingPathComponent("sample.txt")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.text = ""
    }

    // TextViewnにファイルに保存したデータを表示する。
    @IBAction func didTapLoadButton(_ sender: UIButton) {
        do {
            let text = try String(contentsOf: fileUrl)
            textView.text = text
        } catch {
            messageLabel.text = "ファイルのロードに失敗しました。"
            print("Error: \(error)")
        }
        
    }
    
    // 入力されたテキストをファイルに保存する。
    @IBAction func didTapSaveButton(_ sender: UIButton) {
        guard let text = textView.text else { return }
    
        if FileManager.default.fileExists(atPath: fileUrl.path) {
            // ファイルに書き込み
            do {
                try text.write(to: fileUrl, atomically: false, encoding: .utf8)
                messageLabel.text = "ファイルに保存しました。"
            } catch {
                print("Error: \(error)")
            }
        } else {
            // ファイルが存在しないため、新規に作成する。
            if FileManager.default.createFile(
                atPath: fileUrl.path,
                contents: text.data(using: .utf8),
                attributes: nil
                ) {
                messageLabel.text = "ファイルを新規作成しました。"
            } else {
                messageLabel.text = "ファイルの新規作成に失敗しました。"
            }
        }
    }
}

