defmodule UdpClientServer do
  @moduledoc """
  Documentation for UdpClientServer.
  """

  @default_server_port 1234
  @local_host {178, 79, 152, 173}

  def launch_server do
    launch_server(@default_server_port)
  end

  def launch_server(port) do
    IO.puts("Launching server on localhost on port #{port}")
    server = Socket.UDP.open!(port)
    serve(server)
  end

  def serve(server) do
    {data, client} = server |> Socket.Datagram.recv!()
    IO.puts("Received: #{data}, from #{inspect(client)}")

    try do
      HTTPoison.start()
      HTTPoison.get!("https://cmed-udp.herokuapp.com/upload/#{data}")
    rescue
      RuntimeError -> IO.puts("Request Timeout")
    end

    serve(server)
  end

  @doc """
  Sends `data` to the `to` value, where `to` is a tuple of
  { host, port } like {{178, 79, 152, 173}, 1234}
  """
  def send_data(data, to) do
    # Without specifying the port, we randomize it
    server = Socket.UDP.open!()
    Socket.Datagram.send!(server, data, to)
  end

  def send_data(data) do
    send_data(data, {@local_host, @default_server_port})
  end
end
