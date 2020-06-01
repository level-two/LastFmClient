import UIKit

class ArtistSearchViewController: UITableViewController, StoryboardLoadable {
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate var navigator: SceneNavigator?

    override func viewDidLoad() {
        super.viewDidLoad()

//        tableView.register(AlbumCardCell.nib,
//                                forCellWithReuseIdentifier: String(describing: AlbumCardCell.self))

        setupView()
    }

    func setupDependencies(navigator: SceneNavigator?) {
        self.navigator = navigator
    }
}

extension ArtistSearchViewController {
    func setupView() {
        setupSearchController()
    }

    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
}

extension ArtistSearchViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
//                                                            for: indexPath) as? AlbumCardCell else {
//                                                                return UITableViewCell()
//        }
//
//        return cell

        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigator?.navigate(to: .artistDetails)
    }
}

extension ArtistSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}
