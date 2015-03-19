# Elixir I18n

## ENV Configs

```elixir
# Default locale
config :i18n, :default, "en"

# Locales path
config :i18n, :path, Path.expand(["test/locales"])

# Locales available
config :i18n, :locales, [ "en", "pt-BR" ]
```

## Todo list

* [x] Use env variables
* [x] Move locales to files
* [x] Default locale
* [ ] Docs
* [ ] Upload in hex.pm
* [ ] Translation interpolation. ex. `My name is ${name}.`
* [ ] Test the compiler
