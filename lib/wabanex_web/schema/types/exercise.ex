defmodule WabanexWeb.Schema.Types.Exercise do
  @moduledoc false

  use Absinthe.Schema.Notation

  @desc "Logic exercise representation"
  object :exercise do
    field :id, non_null(:uuid4), description: "Exercise's id"
    field :name, non_null(:string), description: "Exercise's name"
    field :youtube_video_url, non_null(:string), description: "URL of exercise example video"
    field :protocol_description, non_null(:string), description: "Exercise's protocol"
    field :repetitions, non_null(:string), description: "Exercise's repetitions"
  end

  input_object :create_exercise_input do
    field :name, non_null(:string), description: "Exercise's name"
    field :youtube_video_url, non_null(:string), description: "URL of exercise example video"
    field :protocol_description, non_null(:string), description: "Exercise's protocol"
    field :repetitions, non_null(:string), description: "Exercise's repetitions"
  end
end
