defmodule I18n.Compiler do
  #
  def compile do
    # App env variables
    locales = Application.get_env(:i18n, :locales)

    # Generate methods for each language
    translations = for locale <- locales, do: define_locale(locale)

    # Quote this
    quote do
      unquote(translations)

      def t(lang, path) do
        _t(lang, path)
      end

      def t(path) do
        _t(Application.get_env(:i18n, :default), path)
      end

      defp _t(_locale, _key) do
        "Locale #{_locale} not defined"
      end
    end
  end

  defp define_locale(locale) do
    # File path
    file_path = Path.join [Application.get_env(:i18n, :path), "#{locale}.exs"]

    # Checks file exists
    if File.exists?(file_path) do
      # Eval the translations
      { translations, _ } = Code.eval_file file_path

      # Define the translations
      translations_methods = define_translation(locale, "", translations)

      #
      quote do
        # Translations
        unquote translations_methods

        # Translation missing
        defp _t(unquote(locale), _key) do
          "Translation missing for #{unquote(locale)}.#{_key}"
        end
      end
    end
  end

  defp define_translation(locale, path, value) when is_list(value) do
    # Define translation
    for { k, v } <- value, do: define_translation(locale, define_path(path, k), v)
  end

  defp define_translation(locale, path, value) do
    # Define the method
    quote do
      defp _t(unquote(locale), unquote(path)) do
        unquote value
      end
    end
  end

  defp define_path("", key), do: to_string(key)
  defp define_path(path, key), do: "#{path}.#{key}"
end
