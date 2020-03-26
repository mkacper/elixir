defmodule Mix.Tasks.Deps.Get do
  use Mix.Task

  @shortdoc "Gets all out of date dependencies"

  @moduledoc """
  Gets all out of date dependencies, i.e. dependencies
  that are not available or have an invalid lock.

  ## Command line options

    * `--only` - only fetches dependencies for given environment
    * `--no-archives-check` - does not check archives before fetching deps

  """

  def run(args) do
    unless "--no-archives-check" in args do
      Mix.Task.run("archive.check", args)
    end

    Mix.Project.get!()
    {opts, _, _} = OptionParser.parse(args, switches: [only: :string, target: :string])

    # Fetch all deps by default unless --only or --target is given
    only_opt = if only = opts[:only], do: [env: :"#{only}"], else: []
    target_opt = if target = opts[:target], do: [target: :"#{target}"], else: []
    fetch_opts = only_opt ++ target_opt

    apps = Mix.Dep.Fetcher.all(%{}, Mix.Dep.Lock.read(), fetch_opts)

    if apps == [] do
      Mix.shell().info("All dependencies are up to date")
    else
      :ok
    end
  end
end
