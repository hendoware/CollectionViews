import UIKit

class TableViewController: UITableViewController {
    //Data Source Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return ColorHelper.shared.sectionCount
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ColorHelper.shared.rowsFor(section: section)
    }
    
    let reuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? TableViewCell else {fatalError("Misconfigured table cell")}
        
        cell.nameLabel.text = ColorHelper.shared.nameFor(indexPath: indexPath)
        cell.swatch.backgroundColor = ColorHelper.shared.colorFor(indexPath: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .lightGray
        label.text = ColorHelper.shared.keyFor(indexPath: IndexPath(row: 0, section: section))
        return label
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return ColorHelper.shared.modelKeys
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}
