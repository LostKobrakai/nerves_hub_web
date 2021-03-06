defmodule NervesHubWWWWeb.ConnCase.Browser do
  @moduledoc """
  conn case for browser related tests
  """
  alias NervesHubWebCore.{Accounts, Fixtures}
  alias NervesHubWWWWeb.ConnCase
  alias Plug.Test

  defmacro __using__(opts) do
    quote do
      use ConnCase, unquote(opts)
      import Test
      import Phoenix.LiveViewTest

      setup do
        fixture = Fixtures.standard_fixture()

        %{org: org, org_key: org_key, user: user} = fixture

        {:ok, org_with_org_keys} = Accounts.get_org_with_org_keys(org.id)

        conn =
          build_conn()
          |> Map.put(:assigns, %{org: org_with_org_keys, user: user})
          |> init_test_session(%{
            "auth_user_id" => user.id
          })

        %{conn: conn, user: user, org: org, fixture: fixture, org_key: org_key}
      end
    end
  end
end
