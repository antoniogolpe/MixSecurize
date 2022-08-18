Repo.paginate(Album, params)

assert_raise(ArgumentError, ~r/^cannot deserialize.+/, fn ->
  payments_by_amount_and_charged_at(:asc, :desc)
  |> Repo.paginate(
    cursor_fields: [amount: :asc, charged_at: :desc, id: :asc],
    before: payload,
    limit: 3
  )
end)
