defmodule WabanexWeb.Resolvers.Instructor do
  @moduledoc false

  def get(%{id: instructor_id}, _context), do: Wabanex.Instructors.Get.call(instructor_id)

  def create(%{input: params}, _context), do: Wabanex.Instructors.Create.call(params)

end
