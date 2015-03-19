defmodule I18n.Translator do
  defmacro __using__(_options) do
    # Quote!
    quote do
      # Before compile action
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(_env) do
    # Invoke compiler
    I18n.Compiler.compile()
  end
end
