//
//  ViewController.swift
//  NetworkProject
//
//  Created by Данила Бондаренко on 01.10.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var dataSource = [Post]()

    let network = Network()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        network.obtainPosts { [weak self] (result) in
            switch result {
            
            case .success(posts: let posts):
                self?.dataSource = posts

                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }

            case .fail(error: let error):
                print("Error: \(error)")
            }
        }
    }


    
}

// MARK: - TableView
extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let post = dataSource[indexPath.row]

        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.body
        return cell
    }
}
