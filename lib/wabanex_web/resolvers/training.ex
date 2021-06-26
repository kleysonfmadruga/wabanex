defmodule WabanexWeb.Resolvers.Training do
  @moduledoc false

  def create(%{input: params}, _context), do: Wabanex.Trainings.Create.call(params)

  def get(%{id: training_id}, _context), do: Wabanex.Trainings.Get.call(training_id)
end
