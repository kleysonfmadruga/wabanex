defmodule WabanexWeb.Schema do
  @moduledoc false

  use Absinthe.Schema

  import_types WabanexWeb.Schema.Types.Root

  query do
    import_fields :root_query
  end

  mutation do
    import_fields :root_mutation
  end
end
