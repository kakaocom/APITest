//
//  ArticleListViewController.swift
//  APITest
//
//  Created by Takao on 2016/12/23.
//  Copyright © 2016年 TakaoHoriguchi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ArticleListViewController: UIViewController, UITableViewDataSource {

    let table: UITableView = UITableView()
    var articles: [[String:String?]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.frame = view.frame
        view.addSubview(table)
        table.dataSource = self
        
        title = "新着記事"
        
        getArticle()

    }
    
    func getArticle() {
        Alamofire.request("https://qiita.com/api/v2/items", method: .get).responseJSON { (response) in
            
            guard let object = response.result.value else {
                return
            }
            print(response.result.value)
            let json = JSON(object)
            json.forEach({ (_, json) in
                let article:[String:String?] = ["title":json["title"].string, "userId":json["user"]["id"].string]
                self.articles.append(article)
            })
            self.table.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let article = articles[indexPath.row]
        
        cell.textLabel?.text = article["title"]!
        cell.detailTextLabel?.text = article["userId"]!
        return cell
    }
    
    

}
