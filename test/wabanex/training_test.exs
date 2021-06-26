defmodule Wabanex.TrainingTest do
  @moduledoc false

  use Wabanex.DataCase, async: true

  alias Wabanex.{Student, Training}
  alias Ecto.Changeset

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      student_params = %{name: "José", email: "jose@gmail.com", password: "12345678"}

      {:ok, %{id: student_id}} = student_params |> Student.changeset() |> Repo.insert()

      training_params = %{
        student_id: student_id,
        start_date: ~D[2021-06-26],
        end_date: ~D[2021-07-26],
        exercises: [
          %{
            name: "Treino de braço",
            protocol_description: "regular",
            repetitions: "3x12",
            youtube_video_url: "https://www.youtube.com/watch?v=4iVV4btbBM0"
          },
          %{
            name: "Treino de perna",
            protocol_description: "regular",
            repetitions: "5x8",
            youtube_video_url: "https://www.youtube.com/watch?v=wSbHyGBWs2o"
          }
        ]
      }

      response = Training.changeset(training_params)

      assert %Changeset{
        errors: [],
        valid?: true,
        changes: %{
          student_id: ^student_id,
          start_date: ~D[2021-06-26],
          end_date: ~D[2021-07-26],
          exercises: [
            %Changeset{
              errors: [],
              valid?: true,
              changes: %{
                name: "Treino de braço",
                protocol_description: "regular",
                repetitions: "3x12",
                youtube_video_url: "https://www.youtube.com/watch?v=4iVV4btbBM0"
              }
            },
            %Changeset{
              errors: [],
              valid?: true,
              changes: %{
                name: "Treino de perna",
                protocol_description: "regular",
                repetitions: "5x8",
                youtube_video_url: "https://www.youtube.com/watch?v=wSbHyGBWs2o"
              }
            }
          ]
        }
      } = response
    end
  end
end
