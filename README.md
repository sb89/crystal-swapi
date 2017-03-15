# crystal-swapi

Star Wars API (SWAPI) for Crystal.

Documentation: https://swapi.co/documentation

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  swapi:
    github: sb89/crystal-swapi
```

## Basic Usage

```crystal
require "swapi"

luke = Swapi::Person.get 1

p luke.birth_year

tatooine = Swapi::Planet.get 1

p tatooine.climate
```

## Get

`get` can be called with an index (as seen above) or with no index, which will return all:

```crystal
planets = Swapi::Planet.get

planets.results.each do |planet|
  p planet.name
end

if planets.next?
  planets = planets.get_next

  planets.results.each do |planet|
    p planet.name
  end
end 
```

## Search

```crystal
planets = Swapi::Planet.search "oine"

planets.results.each do |planet|
  p planet.name
end
```

## List
Both `search` and `get` (without an index) return a `List`:

```crystal
planets = Swapi::Planet.get

planets.count # Total number of planets

planets.results # Contains the current batch of planets

planets.next? # Is there another batch of planets?

planets = planets.get_next # Get list for next batch of planets

planets.previous? # Is there a previous batch of planets?

planets = planets.get_previous # Get list for previous batch of planets
```

## Linked Resources
All resources are linked to some form of other resource. For example, a `Person` has `films`, `species`, `starships` and `vehicles`. The API returns these as urls to another resource. We can call `get_<resource>` e.g. `get_films` to get an array  the actual objects:

```crystal
planet = Swapi::Planet.get 1

p planet.films # This will print an array of urls

planet.get_films.each { |f| p f.title } # Use get_films to get the actual film objects and print their titles
```


## Contributing

1. Fork it ( https://github.com/sb89/crystal-swapi/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [sb89](https://github.com/[your-github-name]) Steven - creator, maintainer
