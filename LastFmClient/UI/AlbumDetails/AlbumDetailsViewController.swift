import UIKit

class AlbumDetailsViewController: UITableViewController, StoryboardLoadable {
    fileprivate var navigator: SceneNavigator?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerReusableHeaderFooter(AlbumDetailsHeaderView.self)
        tableView.registerReusableCell(AlbumDetailsTrackCell.self)
    }

    func setupDependencies(navigator: SceneNavigator?) {
        self.navigator = navigator
    }
}

extension AlbumDetailsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.numberOfTracks
        return 100
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(AlbumDetailsHeaderView.self)
//        header.configure(with: viewModel.headerModel)
        return header
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(AlbumDetailsTrackCell.self, for: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Show artist details when name clicked
//        navigator?.navigate(to: .artistDetails)
    }
}
