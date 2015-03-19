defmodule TranslatorTest do
  use ExUnit.Case

  # Env variables
  Application.put_env :i18n, :default, "en"
  Application.put_env :i18n, :path, Path.expand(["test/locales"])
  Application.put_env :i18n, :locales, [ "en", "pt-BR" ]

  # Define module
  defmodule I18nTest do
    use I18n.Translator
  end

  test "translate single path using default locale" do
    assert I18nTest.t("single") == "Single"
    assert I18nTest.t("other_single") == "Other single"
  end

  test "translate multiple path using default locale" do
    assert I18nTest.t("mixed.hello") == "Hello"
    assert I18nTest.t("mixed.name") == "My name is ..."
    assert I18nTest.t("mixed.more.possible") == "True"
  end

  test "translate single path using specific locale" do
    assert I18nTest.t("pt-BR", "single") == "Simples"
    assert I18nTest.t("pt-BR", "other_single") == "Outro simples"
  end

  test "translate multiple path using specific locale" do
    assert I18nTest.t("pt-BR", "mixed.hello") == "Olá"
    assert I18nTest.t("pt-BR", "mixed.name") == "Meu nome é ..."
    assert I18nTest.t("pt-BR", "mixed.more.possible") == "Verdade"
  end

  test "undefined translation" do
    assert I18nTest.t("undefined") == "Translation missing for en.undefined"
    assert I18nTest.t("pt-BR", "undefined") == "Translation missing for pt-BR.undefined"
  end

  test "undefined locale" do
    assert I18nTest.t("fr", "single") == "Locale fr not defined"
  end
end
