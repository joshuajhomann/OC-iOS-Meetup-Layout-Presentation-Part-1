import UIKit
import PlaygroundSupport
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

struct RedditPost: Mappable {
    static let PostKeyPath = "data.children"
    var commentCount = 0
    var title = ""
    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        title <- map["data.title"]
        commentCount <- map["data.num_comments"]
    }
}

extension UIView {
    func constrainToSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSLayoutAttribute] = [.leading, .trailing, .top, .bottom]
        attributes.forEach { attribute in
            NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: self.superview, attribute: attribute, multiplier: 1, constant: 0).isActive = true
        }
    }
}

class TableViewController: UIViewController, UITableViewDataSource {
    var tableView = UITableView()
    private var posts: [RedditPost] = []
    private var isLoading = false
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.constrainToSuperview()
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat.ulpOfOne, height: .ulpOfOne))
        let button = UIButton()
        button.setTitle("Refresh", for: .normal)
        button.backgroundColor = .red
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 24).isActive = true
        NSLayoutConstraint(item: button, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 2.0/4.0, constant: 0).isActive = true
        refresh()


    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: String(describing: TableViewController.self))
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: String(describing: TableViewController.self))
        }
        cell.textLabel?.text = posts[indexPath.row].title
        cell.detailTextLabel?.text = "Comments:\(posts[indexPath.row].commentCount)"
        return cell
    }

    @objc private func refresh() {
        guard isLoading == false else {
            return
        }
        Alamofire.request(URL(string: "http://reddit.com/.json")!).responseArray(keyPath: RedditPost.PostKeyPath) { (response: DataResponse<[RedditPost]>) in
            print(response)
            if let posts = response.result.value {
                self.posts = posts
                self.isLoading = false
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

}

let t = TableViewController()
t.view.frame = CGRect(x: 0, y: 0, width: 600, height: 600)
PlaygroundPage.current.liveView = t.view
PlaygroundPage.current.needsIndefiniteExecution = true






