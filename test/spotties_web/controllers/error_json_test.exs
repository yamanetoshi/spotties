defmodule SpottiesWeb.ErrorJSONTest do
  use SpottiesWeb.ConnCase, async: true

  test "renders 404" do
    assert SpottiesWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert SpottiesWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
