defmodule Spotties do
  @moduledoc """
  Spotties keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  use Application

  def config_dir() do
    Path.join([Desktop.OS.home(), ".config", "spotties"])
  end

  @app Mix.Project.config()[:app]
  def start(:normal, []) do
    File.mkdir_p!(config_dir())
    # DB周り
    {:ok, sup} = Supervisor.start_link([Spotties.Repo], name: __MODULE__, strategy: :one_for_one)
    # PubSubとEndpoint,session周り
    {:ok, _} = Supervisor.start_child(sup, SpottiesWeb.Sup)
    # Desktop周り
    #port = :ranch.get_port(SpottiesWeb.Endpoint.HTTP)
    port = "4000"
    {:ok, _} =
      Supervisor.start_child(sup, {
        Desktop.Window,
        [
          app: @app,
          id: SpottiesWindow,
          title: "Spotties",
          size: {400, 800},
          url: "http://localhost:#{port}"
        ]
      })
  end  
end
