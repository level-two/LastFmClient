protocol ArtistSearchHistoryService {
    func addToSearchHistory(_ artistSearchItem: ArtistSearchItem)
    func removeFromSearchHistory(_ mbid: String)
    func searchHistory() -> [ArtistSearchItem]
}
