defmodule TeternikovWeb.AdminPageControllerTest do
  require IEx
  use TeternikovWeb.ConnCase

  alias Teternikov.Pages
  alias Teternikov.Coherence.User
  alias Teternikov.Repo

  @create_attrs %{body: "some body", title: "some title", url: "some url"}
  @update_attrs %{body: "some updated body", title: "some updated title", url: "some updated url"}
  @invalid_attrs %{body: nil, title: nil, url: nil}

  def fixture(:page) do
    {:ok, page} = Pages.create_page(@create_attrs)
    page
  end

  defp create_page(_) do
    page = fixture(:page)
    {:ok, page: page}
  end

  defp login(%{conn: conn}) do
    user =
      User.changeset(%User{}, %{
        name: "admin",
        email: "admin@example.com",
        password: "test",
        password_confirmation: "test",
        admin: true
      })
      |> Repo.insert!()

    {:ok, conn: assign(conn, :current_user, user)}
  end

  setup %{conn: conn} do
    login(%{conn: conn})
  end

  describe "index" do
    test "lists all pages", %{conn: conn} do
      conn = get(conn, admin_page_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Pages"
    end

    test "does not allow access for non admin users", %{conn: conn} do
      user =
        User.changeset(%User{}, %{
          name: "test",
          email: "test@example.com",
          password: "test",
          password_confirmation: "test"
        })
        |> Repo.insert!()

      conn = assign(conn, :current_user, user)
      conn = get(conn, admin_page_path(conn, :index))
      assert redirected_to(conn) == "/"
      # assert html_response(conn, 200) =~ "Listing Pages"
    end
  end

  describe "new page" do
    test "renders form", %{conn: conn} do
      conn = get(conn, admin_page_path(conn, :new))
      assert html_response(conn, 200) =~ "New Page"
    end
  end

  describe "create page" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, admin_page_path(conn, :create), page: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == admin_page_path(conn, :show, id)
      saved_assigns = conn.assigns

      conn =
        conn
        |> recycle()
        |> Map.put(:assigns, saved_assigns)

      conn = get(conn, admin_page_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Page"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, admin_page_path(conn, :create), page: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Page"
    end
  end

  describe "edit page" do
    setup [:create_page]

    test "renders form for editing chosen page", %{conn: conn, page: page} do
      conn = get(conn, admin_page_path(conn, :edit, page))
      assert html_response(conn, 200) =~ "Edit Page"
    end
  end

  describe "update page" do
    setup [:create_page]

    test "redirects when data is valid", %{conn: conn, page: page} do
      conn = put(conn, admin_page_path(conn, :update, page), page: @update_attrs)
      assert redirected_to(conn) == admin_page_path(conn, :show, page)
      saved_assigns = conn.assigns

      conn =
        conn
        |> recycle()
        |> Map.put(:assigns, saved_assigns)

      conn = get(conn, admin_page_path(conn, :show, page))
      assert html_response(conn, 200) =~ "some updated body"
    end

    test "renders errors when data is invalid", %{conn: conn, page: page} do
      conn = put(conn, admin_page_path(conn, :update, page), page: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Page"
    end
  end

  describe "delete page" do
    setup [:create_page]

    test "deletes chosen page", %{conn: conn, page: page} do
      conn = delete(conn, admin_page_path(conn, :delete, page))
      assert redirected_to(conn) == admin_page_path(conn, :index)
      saved_assigns = conn.assigns

      conn =
        conn
        |> recycle()
        |> Map.put(:assigns, saved_assigns)

      assert_error_sent(404, fn ->
        get(conn, admin_page_path(conn, :show, page))
      end)
    end
  end
end
