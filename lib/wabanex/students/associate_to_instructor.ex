defmodule Wabanex.Students.AssociateToInstructor do
  @moduledoc false

  alias Ecto.{Changeset, Multi}
  alias Wabanex.{Instructor, Student, Repo}

  def call(%{student_id: student_id, instructor_id: instructor_id}) do
    Multi.new()
    |> Multi.run(
      :get_instructor,
      fn repo, _struct ->
        case repo.get(Instructor, instructor_id) do
          nil -> {:error, "Instructor not found"}
          instructor -> {:ok, instructor}
        end
      end
    )
    |> Multi.run(
      :get_user,
      fn repo, _struct ->
        case repo.get(Student, student_id) do
          nil -> {:error, "Student not found"}
          student -> {:ok, student}
        end
      end
    )
    |> Multi.run(
      :preload_data,
      fn repo, %{get_user: student} ->
        repo
        |> preload_data(student)
      end
    )
    |> Multi.run(
      :associate_to_student,
      fn repo, %{get_instructor: instructor, preload_data: student} ->
        student
        |> student_changeset(instructor)
        |> repo.update()
      end
    )
    |> run_transaction()
  end

  defp student_changeset(student, instructor) do
    student
    |> Changeset.change(%{instructor: instructor})
  end

  defp preload_data(repo, student) do
    {:ok, repo.preload(student, :instructor)}
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{associate_to_student: student}} -> {:ok, student}
    end
  end
end
