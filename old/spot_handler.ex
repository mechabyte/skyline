defmodule SpotApp.Handler do
  use GenServer

  def start_link(ref, socket, transport, opts) do

    #{:ok, pid} = GenServer.start_link(__MODULE__, [ref, socket, transport, opts])
    {:ok, self()}
  end

  def init([ref, socket, transport, opts = []]) do

    {:ok, pid} = GenServer.start_link(__MODULE__, [ref, socket, transport, opts])
    {:ok, {0, ref, socket, transport}, 0}
    #GenServer.enter_loop(__MODULE__, [], {:loop, socket, transport})
  end

  def handle_info(:timeout, {state, ref, socket, transport}) do
    IO.inspect "State #{inspect state}"
    :ok = :ranch.accept_ack(ref)
    #:gproc.reg({:p, :l, :spotmq})
    {:noreply, state, 5000}
  end

  def handle_info({:loop, socket, transport}, state) do
    IO.inspect "Loop #{inspect socket} in process #{inspect self()}"
    IO.inspect "State #{inspect state}"
    {:noreply, state, 5000}
  end

  def handle_info(args, state) do
    IO.inspect "Got #{inspect args} in process #{inspect self()}"
    IO.inspect "State #{inspect state}"
    {:noreply, state, 5000}
  end


  def handle_info(args, state, :_) do
    IO.inspect "ALLLLLL #{inspect args} in process #{inspect self()}"
    IO.inspect "State #{inspect state}"
    {:noreply, state, 5000}
  end

  def handle_info(args) do
    IO.inspect "ALLLLLL #{inspect args} in process #{inspect self()}"
    {:noreply, args}
  end
  def handle_info(args, state, :_) do
    IO.inspect "ALLLLLL #{inspect args} in process #{inspect self()}"
    IO.inspect "State #{inspect state}"
    {:noreply, state}
  end
  def handle_info(args, state, :_, :_) do
    IO.inspect "ALLLLLL #{inspect args} in process #{inspect self()}"
    IO.inspect "State #{inspect state}"
    {:ok, state}
  end
  def handle_info(args, state, :_, :_, :_) do
    IO.inspect "ALLLLLL #{inspect args} in process #{inspect self()}"
    IO.inspect "State #{inspect state}"
    {:ok, state}
  end
  def handle_call(args, state, :_) do
    IO.inspect "ALLLLLL #{inspect args} in process #{inspect self()}"
    IO.inspect "State #{inspect state}"
    {:ok, state}
  end
  def handle_call(args, state) do
    IO.inspect "ALLLLLL #{inspect args} in process #{inspect self()}"
    IO.inspect "State #{inspect state}"
    {:ok, state}
  end
  def handle_cast(args, state, :_) do
    IO.inspect "ALLLLLL #{inspect args} in process #{inspect self()}"
    IO.inspect "State #{inspect state}"
    {:ok, state}
  end
  def handle_cast(args, state) do
    IO.inspect "ALLLLLL #{inspect args} in process #{inspect self()}"
    IO.inspect "State #{inspect state}"
    {:ok, state}
  end
  def info(args, state) do
    IO.inspect "Got #{inspect args} in process #{inspect self()}"
    IO.inspect "State #{inspect state}"
    {:ok, state}
  end
  def handle_cast(args, state) do
    IO.inspect "Got #{inspect args} in process #{inspect self()}"
    IO.inspect "State #{inspect state}"
    {:ok, state}
  end
  def loop(socket, transport) do
    case transport.recv(socket, 0, 5000) do
      {:ok, data} ->

        transport.send(socket, data)
        loop(socket, transport)
      _ ->
        :ok = transport.close(socket)
    end
  end

end