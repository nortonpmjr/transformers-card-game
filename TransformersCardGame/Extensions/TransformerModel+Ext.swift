extension TransformerModel {

    public var dictionary: [String: Any] {
        return ["name": name,
                "strength": strength,
                "intelligence": intelligence,
                "speed": speed,
                "endurance": endurance,
                "rank": rank,
                "courage": courage,
                "firepower": firepower,
                "skill": skill,
                "team": team.rawValue]
    }

    public var overallRating: Int {
        return strength + intelligence + speed + endurance + firepower
    }
}
