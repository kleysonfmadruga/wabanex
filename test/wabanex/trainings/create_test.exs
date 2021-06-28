defmodule Wabanex.Trainings.CreateTest do
  @moduledoc false

  use Wabanex.DataCase, async: true

  alias Wabanex.{Students, Trainings}

  describe "call/1" do
    test "when valid params are given, creates and returns a training" do
      student_params = %{name: "José", email: "jose@gmail.com", password: "12345678"}
      exercise_params = %{name: "Treino de braço", protocol_description: "padrão", repetitions: "3x12", youtube_video_url: "www.youtube.com.br"}

      {:ok, %{id: student_id}} = student_params |> Students.Create.call()

      training_params = %{student_id: student_id, start_date: ~D[2021-06-28], end_date: ~D[2021-07-10], exercises: [exercise_params]}

      response = training_params |> Trainings.Create.call()

      assert {:ok,
        %Wabanex.Training{
          end_date: ~D[2021-07-10],
          exercises: [
            %Wabanex.Exercise{
              id: _id,
              name: "Treino de braço",
              protocol_description: "padrão",
              repetitions: "3x12",
              training_id: training_id,
              youtube_video_url: "www.youtube.com.br"
            }
          ],
          id: training_id,
          start_date: ~D[2021-06-28],
          student_id: ^student_id
        }
      } = response
    end
  end
end
