defmodule WabanexWeb.Resolvers.Student do
  @moduledoc false

  def get(%{id: student_id}, _context), do: Wabanex.Students.Get.call(student_id)

  def create(%{input: params}, _context), do: Wabanex.Students.Create.call(params)

  def associate_to_instructor(%{input: params}, _context), do: Wabanex.Students.AssociateToInstructor.call(params)
end
